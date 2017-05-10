class RmPlatformNo < ActiveRecord::Migration[5.0]
  def change
  	remove_column :approval_triggered_events, :platform_no 
  end
end
