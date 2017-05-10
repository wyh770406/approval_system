class CreateApprovalFlows < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_flows do |t|

      t.string :name
      t.string :class_name
      t.integer :class_id
      t.string :platform_no
      t.string :approval_initiator

      t.timestamps
    end
  end
end
