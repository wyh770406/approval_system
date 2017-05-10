class ApprovalFlowInvoice < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_flow_invoices do |t|
      t.integer :invoice_id
      t.belongs_to :approval_flow

      t.timestamps
    end

    remove_column :approval_flows, :class_id
  end
end
