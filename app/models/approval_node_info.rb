# == Schema Information
#
# Table name: approval_node_infos
#
#  id                       :integer          not null, primary key
#  approval_time            :datetime
#  approval_status          :integer          default(0)
#  approval_advice          :text
#  approval_node_id         :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  approval_flow_invoice_id :integer
#  approval_username        :string           default("")
#
# Indexes
#
#  index_approval_node_infos_on_approval_flow_invoice_id  (approval_flow_invoice_id)
#  index_approval_node_infos_on_approval_node_id          (approval_node_id)
#

class ApprovalNodeInfo < ApplicationRecord
end
