# == Schema Information
#
# Table name: approval_nodes
#
#  id                    :integer          not null, primary key
#  approval_flow_id      :integer
#  node_desc             :string
#  approval_processer    :string           is an Array
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  prev_approval_node_id :integer          default(0)
#  node_name             :string           default("")
#
# Indexes
#
#  index_approval_nodes_on_approval_flow_id  (approval_flow_id)
#

class ApprovalNode < ApplicationRecord
end
