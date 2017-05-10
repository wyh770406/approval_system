class ChangeApprovalStatus < ActiveRecord::Migration[5.0]
  def change
  	change_column :approval_node_infos, :approval_status, 'integer USING CAST(approval_status AS integer)', :default=>0 
  end
end
