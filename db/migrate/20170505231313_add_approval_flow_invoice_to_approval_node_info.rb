class AddApprovalFlowInvoiceToApprovalNodeInfo < ActiveRecord::Migration[5.0]
  def change
    add_reference :approval_node_infos, :approval_flow_invoice, foreign_key: true
  end
end
