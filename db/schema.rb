# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_23_053419) do

  create_table "admissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title", null: false
    t.datetime "start", null: false
    t.datetime "finish", null: false
    t.string "detail", null: false
    t.string "prace", null: false
    t.string "campany", null: false
    t.string "representative", null: false
    t.string "tell", null: false
    t.string "worker1", null: false
    t.string "worker2", null: false
    t.string "worker3", null: false
    t.string "worker4", null: false
    t.boolean "Aerial"
    t.boolean "Firearm"
    t.string "Notice"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_admissions_on_user_id"
  end

  create_table "passes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "first_user_id"
    t.integer "first_approval"
    t.bigint "second_user_id"
    t.integer "second_approval"
    t.bigint "third_user_id"
    t.integer "third_approval"
    t.bigint "final_user_id"
    t.integer "final_approval"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["final_user_id"], name: "index_passes_on_final_user_id"
    t.index ["first_user_id"], name: "index_passes_on_first_user_id"
    t.index ["second_user_id"], name: "index_passes_on_second_user_id"
    t.index ["third_user_id"], name: "index_passes_on_third_user_id"
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "pdf"
    t.string "message", null: false
    t.bigint "user_id"
    t.integer "kind", default: 1, null: false
    t.datetime "deadline", null: false
    t.integer "status", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "admissions", "users"
  add_foreign_key "passes", "users", column: "final_user_id"
  add_foreign_key "passes", "users", column: "first_user_id"
  add_foreign_key "passes", "users", column: "second_user_id"
  add_foreign_key "passes", "users", column: "third_user_id"
end
