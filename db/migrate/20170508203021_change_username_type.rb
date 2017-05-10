class ChangeUsernameType < ActiveRecord::Migration[5.0]
  def change
  	change_column :approval_node_infos, :approval_username, :string, :default=>""  	  	
  end
end
