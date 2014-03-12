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

ActiveRecord::Schema.define(version: 20140312180725) do

  create_table "chores", force: true do |t|
    t.string   "name"
    t.integer  "house_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",     default: false
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id"
  end

  create_table "expenses", force: true do |t|
    t.string   "description"
    t.integer  "house_id"
    t.integer  "user_id"
    t.boolean  "status",      default: false
    t.float    "amount"
    t.integer  "roommates"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.string   "description"
    t.integer  "user_id"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "image"
  end

  create_table "shoppinglists", force: true do |t|
    t.string   "name"
    t.boolean  "status",     default: false
    t.integer  "house_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenancies", force: true do |t|
    t.integer  "user_id"
    t.integer  "house_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenancies", ["user_id", "house_id"], name: "index_tenancies_on_user_id_and_house_id", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                        null: false
    t.string   "crypted_password",             null: false
    t.string   "salt",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "hometown"
    t.integer  "phone_number"
    t.string   "bio"
    t.string   "interests"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"

end
