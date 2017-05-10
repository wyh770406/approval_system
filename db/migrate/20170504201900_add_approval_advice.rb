class AddApprovalAdvice < ActiveRecord::Migration[5.0]
  def change
    add_column :approval_nodes, :approval_advice, :text  	
  end
end
