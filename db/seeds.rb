# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
User.create([
  { username: '000000', password: '000000' },
])
ApprovalFlow.delete_all
ApprovalFlow.create([
  { class_name: 'OtherStockInInvoice', platform_no: "WAREHOUSE" },
])
ApprovalNode.delete_all
ApprovalNode.create([
  { approval_flow_id: 1, approval_processer: ["张三","000000"] },
])
