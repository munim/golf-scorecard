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

ActiveRecord::Schema.define(version: 20170417142139) do

  create_table "addresses", force: :cascade do |t|
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "post_code"
    t.string "country"
    t.string "location"
  end

  create_table "courses", force: :cascade do |t|
    t.string  "name"
    t.integer "address_id"
    t.integer "total_holes", limit: 1
    t.integer "par",         limit: 1
    t.index ["address_id"], name: "index_courses_on_address_id"
  end

  create_table "groups", id: false, force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "round_id",  null: false
  end

  create_table "holes", force: :cascade do |t|
    t.integer "course_id"
    t.integer "hole_no",      limit: 1
    t.integer "par",          limit: 1
    t.integer "stroke_index", limit: 1
    t.integer "length",       limit: 2
    t.index ["course_id"], name: "index_holes_on_course_id"
  end

  create_table "player_sign_in_histories", force: :cascade do |t|
    t.integer  "player_id"
    t.datetime "sign_in_time"
    t.datetime "sign_out_time"
    t.string   "ip",            limit: 15
    t.index ["player_id"], name: "index_player_sign_in_histories_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string   "username",        limit: 16, null: false
    t.string   "first_name",      limit: 20
    t.string   "last_name",       limit: 20
    t.string   "email",           limit: 50, null: false
    t.string   "password"
    t.date     "date_of_birth"
    t.datetime "account_created"
    t.integer  "address_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["address_id"], name: "index_players_on_address_id"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["username"], name: "index_players_on_username", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "start",     null: false
    t.integer  "course_id"
    t.datetime "end",       null: false
    t.index ["course_id"], name: "index_rounds_on_course_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "round_id"
    t.integer  "player_id"
    t.integer  "hole_id"
    t.integer  "shots",      limit: 1
    t.integer  "putts",      limit: 1
    t.datetime "input_time"
    t.index ["hole_id"], name: "index_scores_on_hole_id"
    t.index ["player_id"], name: "index_scores_on_player_id"
    t.index ["round_id"], name: "index_scores_on_round_id"
  end

end
