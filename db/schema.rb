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

ActiveRecord::Schema.define(version: 20150707223806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "apps", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "key",        null: false
    t.text     "domains"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "apps", ["key"], name: "index_apps_on_key", unique: true, using: :btree

  create_table "event_types", force: :cascade do |t|
    t.integer  "app_id",                 null: false
    t.string   "key",                    null: false
    t.integer  "weight",     default: 0
    t.string   "label"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "event_types", ["app_id", "key"], name: "index_event_types_on_app_id_and_key", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "event_type_id", null: false
    t.integer  "medium_id",     null: false
    t.string   "user_id"
    t.integer  "timestamp",     null: false
    t.integer  "weight"
    t.text     "optional_data"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "events", ["event_type_id", "medium_id", "user_id"], name: "index_events_on_event_type_id_and_medium_id_and_user_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.integer  "app_id",     null: false
    t.string   "media_id",   null: false
    t.integer  "duration",   null: false
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "media", ["app_id", "media_id"], name: "index_media_on_app_id_and_media_id", unique: true, using: :btree

  create_table "play_segments", force: :cascade do |t|
    t.integer  "start_event_id", null: false
    t.integer  "end_event_id",   null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "play_segments", ["start_event_id", "end_event_id"], name: "index_play_segments_on_start_event_id_and_end_event_id", unique: true, using: :btree

end
