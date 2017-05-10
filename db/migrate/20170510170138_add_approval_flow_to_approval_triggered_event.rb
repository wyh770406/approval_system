class AddApprovalFlowToApprovalTriggeredEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference :approval_triggered_events, :approval_flow, foreign_key: true  	
  end
end
