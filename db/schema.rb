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

ActiveRecord::Schema.define(version: 20170129215507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "neighborhood"
    t.string   "street"
    t.string   "number"
    t.string   "zipcode"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "property_id"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "complaiments", force: :cascade do |t|
    t.text     "body"
    t.integer  "property_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.boolean  "wifi"
    t.boolean  "washing_machine"
    t.boolean  "clothes_iron"
    t.boolean  "towels"
    t.boolean  "air_conditioning"
    t.boolean  "heater"
    t.boolean  "refrigerator"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "talk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "photo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id"], name: "index_photos_on_property_id", using: :btree
  end

  create_table "properties", force: :cascade do |t|
    t.decimal  "price"
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "accommodation_type"
    t.integer  "guest_max"
    t.integer  "beds"
    t.integer  "bedroom"
    t.integer  "address_id"
    t.integer  "status"
    t.integer  "facility_id"
    t.integer  "bathroom"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["address_id"], name: "index_properties_on_address_id", using: :btree
    t.index ["facility_id"], name: "index_properties_on_facility_id", using: :btree
    t.index ["user_id"], name: "index_properties_on_user_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.date     "checkin_date"
    t.date     "checkout_date"
    t.integer  "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "talks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "photo"
    t.integer  "kind"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id"], name: "index_wishlists_on_property_id", using: :btree
    t.index ["user_id"], name: "index_wishlists_on_user_id", using: :btree
  end

  add_foreign_key "photos", "properties"
  add_foreign_key "properties", "addresses"
  add_foreign_key "properties", "facilities"
  add_foreign_key "properties", "users"
  add_foreign_key "wishlists", "properties"
  add_foreign_key "wishlists", "users"
end
