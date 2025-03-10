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

ActiveRecord::Schema.define(version: 2021_01_05_214425) do

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "longitude"
    t.float "latitude"
    t.string "address"
  end

  create_table "restaurant_locations", force: :cascade do |t|
    t.integer "location_id"
    t.integer "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurant_styles", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "style_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "price_point"
    t.string "description"
    t.string "street_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "styles", force: :cascade do |t|
    t.string "cuisine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_restaurants", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "favorite?"
    #favorite should be foreign key in User
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
