# == Schema Information
#
# Table name: approval_flow_invoices
#
#  id               :integer          not null, primary key
#  invoice_id       :integer
#  approval_flow_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_approval_flow_invoices_on_approval_flow_id  (approval_flow_id)
#

class ApprovalFlowInvoice < ApplicationRecord
  belongs_to :approval_flow
end
