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

ActiveRecord::Schema.define(version: 20141225153722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "articles", force: true do |t|
    t.string   "author"
    t.string   "subject"
    t.text     "text"
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "name",             default: ""
    t.string   "title",            default: ""
    t.text     "content",          default: ""
    t.text     "ps",               default: ""
    t.string   "sidebar_title",    default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meta_description", default: ""
  end

  create_table "parties", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.text     "ps"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "name",           default: ""
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photoable_id"
    t.string   "photoable_type"
  end

  add_index "photos", ["photoable_id", "photoable_type"], name: "index_photos_on_photoable_id_and_photoable_type", using: :btree

  create_table "recalls", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "text"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "recalls", ["published_at"], name: "index_recalls_on_published_at", using: :btree

  create_table "request_photos", force: true do |t|
    t.string   "photo"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "request_photos", ["request_id"], name: "index_request_photos_on_request_id", using: :btree

  create_table "requests", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "email"
    t.date     "party_date"
    t.string   "vk"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "link"
    t.string   "name"
    t.boolean  "video_main"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "landing",    default: false
  end

  add_index "videos", ["landing"], name: "index_videos_on_landing", using: :btree

end
