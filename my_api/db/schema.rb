# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20200302131406) do

  create_table "accounts", force: :cascade do |t|
    t.string   "number",                   null: false
    t.float    "balance",    default: 0.0
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "transfers", force: :cascade do |t|
    t.string   "amount"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "account_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "transfers", ["account_id"], name: "index_transfers_on_account_id"
  add_index "transfers", ["recipient_id"], name: "index_transfers_on_recipient_id"
  add_index "transfers", ["sender_id"], name: "index_transfers_on_sender_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cpf",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["cpf"], name: "index_users_on_cpf", unique: true

  create_table "withdraws", force: :cascade do |t|
    t.string   "amount"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "withdraws", ["account_id"], name: "index_withdraws_on_account_id"

end
