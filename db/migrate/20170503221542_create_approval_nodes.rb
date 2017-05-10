class CreateApprovalNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_nodes do |t|
      t.belongs_to 	:approval_flow
      t.string :node_desc
      t.string :approval_processer
      t.datetime :approval_time
      t.string :approval_status

      t.timestamps
    end
  end
end
