class CreateApprovalTriggeredEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_triggered_events do |t|
      t.string :name
      t.string :desc
      t.string :platform_no
      t.string :event_params, array: true, default: []	

      t.timestamps
    end
  end
end
