class AddNodeName < ActiveRecord::Migration[5.0]
  def change
  	add_column :approval_nodes, :node_name, :string, :default=>""  	
  end
end
