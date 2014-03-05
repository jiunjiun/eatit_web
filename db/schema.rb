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

ActiveRecord::Schema.define(version: 20140302070148) do

  create_table "friends", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["friend_id"], name: "index_friends_on_friend_id", using: :btree
  add_index "friends", ["user_id"], name: "index_friends_on_user_id", using: :btree

  create_table "gorup_tasks", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "invite_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gorup_tasks", ["task_id"], name: "index_gorup_tasks_on_task_id", using: :btree
  add_index "gorup_tasks", ["user_id"], name: "index_gorup_tasks_on_user_id", using: :btree

  create_table "pictures", force: true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "name"
    t.string   "size"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["restaurant_id"], name: "index_pictures_on_restaurant_id", using: :btree
  add_index "pictures", ["task_id"], name: "index_pictures_on_task_id", using: :btree
  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

  create_table "restaurants", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.string   "area"
    t.string   "address"
    t.string   "telephone"
    t.integer  "count"
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
    t.string   "status",        limit: 1, default: "N"
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
