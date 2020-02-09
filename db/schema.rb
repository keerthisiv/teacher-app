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

ActiveRecord::Schema.define(version: 20200209234202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "log_events", force: :cascade do |t|
    t.integer  "teacher_id"
    t.datetime "event_time",  null: false
    t.string   "description"
    t.string   "event_type",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_type"], name: "index_log_events_on_event_type", using: :btree
    t.index ["teacher_id"], name: "index_log_events_on_teacher_id", using: :btree
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "log_events", "teachers"
end
