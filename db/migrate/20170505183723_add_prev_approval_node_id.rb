class AddPrevApprovalNodeId < ActiveRecord::Migration[5.0]
  def change
    add_column :approval_nodes, :prev_approval_node_id, :integer, :default=>0  	
  end
end
