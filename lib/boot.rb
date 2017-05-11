require 'sneakers'
require 'json'
require 'bunny'
require 'sneakers/metrics/logging_metrics'
require 'active_support/all'
require File.expand_path('../../config/environment',  __FILE__)

Sneakers.configure :metrics => Sneakers::Metrics::LoggingMetrics.new

class Processor
  include Sneakers::Worker
  # extend ::ActiveSupport::Concern
  from_queue :other_stock_in_invoice


  def work(msg)
    logger.info "hello #{msg}"
    invoice_json = JSON.parse(msg)
    logger.info "hello #{invoice_json}"
    invoice_json_symb=invoice_json.deep_symbolize_keys!

    curr_approval_flow,curr_approval_flow_invoice = process_approval_flow_and_invoice(invoice_json_symb)       
    process_approval_node = process_approval_node_and_info(invoice_json_symb, curr_approval_flow.id,curr_approval_flow_invoice.id )
    handle_triggered_events(curr_approval_flow_invoice)
    ack!
  end

  def process_approval_flow_and_invoice(invoice_json)
  	curr_approval_flow = ApprovalFlow.find_or_create_by({:class_name=>invoice_json[:class_name], :platform_no=>invoice_json[:platform_no]})
    curr_approval_flow_invoice = ApprovalFlowInvoice.find_or_create_by({:invoice_id=>invoice_json[:class_id], :approval_flow_id=>curr_approval_flow.id})
    [curr_approval_flow,curr_approval_flow_invoice]
  end

  def process_approval_node_and_info(invoice_json, flow_id, flow_invoice_id)
  	curr_node_obj = ApprovalNode.where("? = ANY(approval_processer) and approval_flow_id = ?", invoice_json[:approval_username], flow_id).first
  	approval_node_info = ApprovalNodeInfo.find_or_create_by({:approval_node_id=>curr_node_obj.id, :approval_flow_invoice_id=>flow_invoice_id})
  	curr_approval_node_info = curr_node_obj && approval_node_info.update_attributes!({:approval_time=>Time.now, :approval_status=>invoice_json[:approval_status], :approval_advice=>invoice_json[:approval_advice], :approval_username=>invoice_json[:approval_username]})
    curr_approval_node_info
  end

  def handle_triggered_events(curr_approval_flow_invoice)
  	approval_triggered_events = ApprovalTriggeredEvent.where({:approval_flow_id=>curr_approval_flow_invoice.approval_flow.id})
  	approval_triggered_events.each do |approval_triggered_event|
	  conn = Bunny.new
	  conn.start

	  ch = conn.create_channel   
	  queue_name = case approval_triggered_event.approval_flow.platform_no
              	   when "WAREHOUSE" 
              	     "warehouse_triggered_events"
              	   end
	  q  = ch.queue(queue_name, :durable => true, :auto_delete=>false)
	    #x = Bunny::Exchange.new(ch, :direct, "other_stock_in_invoice_approval", :durable => true)
	  x = ch.default_exchange

	  json_to_pub = {:msg=>"OK", :class_id=>curr_approval_flow_invoice.id, :class_name=>approval_triggered_event.approval_flow.class_name, :event_type=>approval_triggered_event.event_type }.to_json

	  x.publish(json_to_pub, :routing_key => q.name)           		
  	end
  end
end