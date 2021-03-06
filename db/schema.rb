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

ActiveRecord::Schema.define(version: 2018_11_23_232453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authem_sessions", force: :cascade do |t|
    t.string "role", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.string "token", limit: 60, null: false
    t.datetime "expires_at", null: false
    t.integer "ttl", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at", "subject_type", "subject_id"], name: "index_authem_sessions_subject"
    t.index ["expires_at", "token"], name: "index_authem_sessions_on_expires_at_and_token", unique: true
    t.index ["subject_type", "subject_id"], name: "index_authem_sessions_on_subject_type_and_subject_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "org_name"
    t.string "address_line_one"
    t.string "room_number"
    t.string "building_name"
    t.string "food_type"
    t.boolean "vegan"
    t.boolean "vegetarian"
    t.decimal "lat"
    t.decimal "long"
    t.date "date"
    t.time "time"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "password_reset_token", limit: 60, null: false
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_confirmed"
    t.string "confirmation_token"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
