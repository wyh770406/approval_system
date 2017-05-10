# == Schema Information
#
# Table name: approval_triggered_events
#
#  id               :integer          not null, primary key
#  name             :string
#  desc             :string
#  event_params     :string           default([]), is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  event_type       :integer
#  approval_flow_id :integer
#
# Indexes
#
#  index_approval_triggered_events_on_approval_flow_id  (approval_flow_id)
#

class ApprovalTriggeredEvent < ApplicationRecord
  belongs_to :approval_flow	
end
