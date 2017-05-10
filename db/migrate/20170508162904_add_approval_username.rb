class AddApprovalUsername < ActiveRecord::Migration[5.0]
  def change
  	add_column :approval_node_infos, :approval_username, :integer, :default=>0  	
  end
end
