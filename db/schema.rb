# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170510172305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approval_flow_invoices", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "approval_flow_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["approval_flow_id"], name: "index_approval_flow_invoices_on_approval_flow_id", using: :btree
  end

  create_table "approval_flows", force: :cascade do |t|
    t.string   "name"
    t.string   "class_name"
    t.string   "platform_no"
    t.string   "approval_initiator"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "approval_node_infos", force: :cascade do |t|
    t.datetime "approval_time"
    t.integer  "approval_status",          default: 0
    t.text     "approval_advice"
    t.integer  "approval_node_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "approval_flow_invoice_id"
    t.string   "approval_username",        default: ""
    t.index ["approval_flow_invoice_id"], name: "index_approval_node_infos_on_approval_flow_invoice_id", using: :btree
    t.index ["approval_node_id"], name: "index_approval_node_infos_on_approval_node_id", using: :btree
  end

  create_table "approval_nodes", force: :cascade do |t|
    t.integer  "approval_flow_id"
    t.string   "node_desc"
    t.string   "approval_processer",                              array: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "prev_approval_node_id", default: 0
    t.string   "node_name",             default: ""
    t.index ["approval_flow_id"], name: "index_approval_nodes_on_approval_flow_id", using: :btree
  end

  create_table "approval_triggered_events", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "event_params",     default: [],              array: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "event_type"
    t.integer  "approval_flow_id"
    t.index ["approval_flow_id"], name: "index_approval_triggered_events_on_approval_flow_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

  add_foreign_key "approval_node_infos", "approval_flow_invoices"
  add_foreign_key "approval_triggered_events", "approval_flows"
end
