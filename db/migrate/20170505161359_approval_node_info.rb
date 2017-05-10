class ApprovalNodeInfo < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_node_infos do |t|
      t.datetime :approval_time
      t.string :approval_status
      t.text :approval_advice
      t.belongs_to :approval_node

      t.timestamps
    end

    remove_column :approval_nodes, :approval_time  
    remove_column :approval_nodes, :approval_status     
    remove_column :approval_nodes, :approval_advice   	
    change_column :approval_nodes, :approval_processer, "varchar[] USING (string_to_array(approval_processer, ','))"	
  end
end
