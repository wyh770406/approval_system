require 'ostruct'
class Api::V1::ApprovalNodesController < ActionController::API
  def index
  	# render :json=>{:ttt=>"wwww"}.to_json
  end

  def get_node
  	platform_no, class_name = params[:platform_no], params[:class_name]
    approval_processer = params[:approval_processer]    
    node_obj_attrs = get_user_access_node(platform_no, class_name, approval_processer)
  	render :plain=>node_obj_attrs.to_json
  end	

  def get_invoice_node_info
    platform_no, class_name = params[:platform_no], params[:class_name]
    invoice_id= params[:invoice_id]
    invoice_node_infos = get_invoice_node_infos(platform_no, class_name, invoice_id)
  	invoice_node_infos_hash = (invoice_node_infos && invoice_node_infos.index_by(&:id)) || {}
    
    render :plain=>invoice_node_infos_hash.to_json
  end

  def get_flow_id(invoice_platform_no, invoice_class_name)
  	approval_flow = ApprovalFlow.find_by({:class_name=>invoice_class_name, :platform_no=>invoice_platform_no})
  	approval_flow && approval_flow.id
  end

  def get_user_access_node(platform_no, class_name, approval_processer)
  	flow_id = get_flow_id(platform_no, class_name) 	

  	node_obj = ApprovalNode.where("? = ANY(approval_processer) and approval_flow_id = ?", approval_processer, flow_id)
  	node_obj_attrs = node_obj.first && node_obj.first.attributes
  	node_obj_attrs = node_obj_attrs || {}  	
  	node_obj_attrs
  end

  def get_invoice_node_infos(platform_no, class_name, invoice_id)
  	flow_id = get_flow_id(platform_no, class_name)

  	flow_invoice = ApprovalFlowInvoice.find_by({:invoice_id=>invoice_id, :approval_flow_id=>flow_id})
  	invoice_node_infos = flow_invoice && ApprovalNodeInfo.where(:approval_flow_invoice_id=>flow_invoice.id).order(:id)  
  	invoice_node_infos	
  end

  def get_access_node_and_all_prev_nodes(user_access_node)
  	all_access_nodes = []
  	all_access_nodes << user_access_node
  	while user_access_node.prev_approval_node_id != 0
  	  user_access_node = ApprovalNode.find(user_access_node.prev_approval_node_id).attributes
  	  all_access_nodes <<  OpenStruct.new(user_access_node)
  	end
    all_access_nodes.reverse!
  end

  def get_user_node_access_right
    platform_no, class_name = params[:platform_no], params[:class_name]
    approval_processer = params[:approval_processer]
   	user_access_node = get_user_access_node(platform_no, class_name, approval_processer)

  	if user_access_node.empty?
  	  is_show_button_and_advice_hash = {:is_show_button_and_advice=>false}
  	else

      invoice_id= params[:invoice_id]

      invoice_node_infos = get_invoice_node_infos(platform_no, class_name, invoice_id)
    	all_invoice_info_node_ids = (invoice_node_infos && invoice_node_infos.map{|invoice_node_info| invoice_node_info.approval_node_id}) || []

      
      struct_user_access_node = OpenStruct.new(user_access_node)
      
    	is_show_button_and_advice = (all_invoice_info_node_ids.include? struct_user_access_node.prev_approval_node_id) && !(all_invoice_info_node_ids.include? struct_user_access_node.id) 

      if all_invoice_info_node_ids.empty? && struct_user_access_node.prev_approval_node_id==0
        is_show_button_and_advice = true
      end
    	is_show_button_and_advice_hash = {:is_show_button_and_advice=>is_show_button_and_advice}
    end
    render :plain=>is_show_button_and_advice_hash.to_json
  end
end