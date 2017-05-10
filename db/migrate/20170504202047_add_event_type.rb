class AddEventType < ActiveRecord::Migration[5.0]
  def change
    add_column :approval_triggered_events, :event_type, :integer    	
  end
end
