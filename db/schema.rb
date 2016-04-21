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

ActiveRecord::Schema.define(version: 20160421141631) do

  create_table "groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "group_image", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 4, null: false
    t.integer "group_id", limit: 4, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "amount",        limit: 4
    t.float    "price",         limit: 24
    t.string   "comment",       limit: 255
    t.string   "image",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "restaurant_id", limit: 4
  end

  add_index "items", ["restaurant_id"], name: "index_items_on_restaurant_id", using: :btree

  create_table "items_orders", id: false, force: :cascade do |t|
    t.integer "order_id", limit: 4, null: false
    t.integer "item_id",  limit: 4, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "meal",          limit: 4
    t.integer  "status",        limit: 4
    t.string   "description",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "restaurant_id", limit: 4
  end

  add_index "orders", ["restaurant_id"], name: "index_orders_on_restaurant_id", using: :btree

  create_table "orders_users", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 4, null: false
    t.integer "order_id", limit: 4, null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "menu_image", limit: 255
    t.string   "phone",      limit: 255
    t.string   "location",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "displayname",            limit: 255,                null: false
    t.text     "bio",                    limit: 65535
    t.string   "phone",                  limit: 255
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "items", "restaurants"
  add_foreign_key "orders", "restaurants"
end
