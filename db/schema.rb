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

ActiveRecord::Schema.define(version: 20140327053709) do

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "area"
    t.string   "address"
    t.string   "telephone"
    t.integer  "count",      default: 0
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.integer  "restaurant_id"
    t.integer  "overall",       limit: 1,  default: 0
    t.integer  "delicious",     limit: 1,  default: 0
    t.integer  "service",       limit: 1,  default: 0
    t.integer  "queues",        limit: 1,  default: 0
    t.integer  "feel",          limit: 1,  default: 0
    t.string   "comment",       limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["restaurant_id"], name: "index_scores_on_restaurant_id", using: :btree
  add_index "scores", ["task_id"], name: "index_scores_on_task_id", using: :btree
  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "status",        limit: 1,   default: "N"
    t.string   "name",          limit: 50
    t.string   "url"
    t.string   "note",          limit: 100
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["restaurant_id"], name: "index_tasks_on_restaurant_id", using: :btree
  add_index "tasks", ["url", "restaurant_id", "user_id"], name: "index_tasks_on_url_and_restaurant_id_and_user_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "role",       limit: 2,  default: "GU"
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.string   "fb_id",      limit: 30
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
