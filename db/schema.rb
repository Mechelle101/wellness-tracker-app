# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_06_180808) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "entry_categories", force: :cascade do |t|
    t.integer "entry_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_entry_categories_on_category_id"
    t.index ["entry_id"], name: "index_entry_categories_on_entry_id"
  end

  create_table "nutrition_logs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "meal_type"
    t.string "food_type"
    t.integer "calories"
    t.integer "protein_g"
    t.integer "carbs_g"
    t.integer "fats_g"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entry_id", null: false
    t.index ["entry_id"], name: "index_nutrition_logs_on_entry_id"
    t.index ["user_id"], name: "index_nutrition_logs_on_user_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "message"
    t.string "frequency"
    t.string "time_of_day"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "supplements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.string "dosage"
    t.string "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_supplements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "entries", "users"
  add_foreign_key "entry_categories", "categories"
  add_foreign_key "entry_categories", "entries"
  add_foreign_key "nutrition_logs", "entries"
  add_foreign_key "nutrition_logs", "users"
  add_foreign_key "reminders", "users"
  add_foreign_key "supplements", "users"
end
