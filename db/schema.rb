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

ActiveRecord::Schema[7.1].define(version: 2026_03_11_145445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plant_stages", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.string "name", null: false
    t.integer "stage_order", null: false
    t.integer "required_points", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id", "stage_order"], name: "index_plant_stages_on_plant_id_and_stage_order", unique: true
    t.index ["plant_id"], name: "index_plant_stages_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_plants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plant_id", null: false
    t.integer "status", default: 0, null: false
    t.integer "accumulated_points", default: 0, null: false
    t.datetime "selected_at", null: false
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_user_plants_on_plant_id"
    t.index ["user_id"], name: "index_user_plants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "display_name"
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "total_growth_points", default: 0, null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "plant_stages", "plants"
  add_foreign_key "user_plants", "plants"
  add_foreign_key "user_plants", "users"
end
