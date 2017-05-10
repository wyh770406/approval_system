# == Schema Information
#
# Table name: approval_flows
#
#  id                 :integer          not null, primary key
#  name               :string
#  class_name         :string
#  platform_no        :string
#  approval_initiator :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ApprovalFlow < ApplicationRecord
  has_many :approval_flow_invoices
  has_many :approval_triggered_events  
end
