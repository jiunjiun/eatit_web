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

ActiveRecord::Schema.define(version: 20140226063321) do

  create_table "restaurants", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.string   "address"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "restaurant_id"
    t.integer  "overall"
    t.integer  "delicious"
    t.integer  "service"
    t.integer  "queues"
    t.integer  "feel"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["restaurant_id"], name: "index_scores_on_restaurant_id", using: :btree
  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "status"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["restaurant_id"], name: "index_tasks_on_restaurant_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "role",       limit: 2,  default: "GU"
    t.string   "name"
    t.string   "email"
    t.string   "fb_id",      limit: 30
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
