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

ActiveRecord::Schema[7.2].define(version: 2025_09_16_013520) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experience_posts", force: :cascade do |t|
    t.string "title", limit: 120, null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "industry_id", null: false
    t.bigint "occupation_id", null: false
    t.string "status", limit: 16, null: false
    t.timestamptz "published_at"
    t.integer "likes_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.index ["created_at"], name: "index_experience_posts_on_created_at"
    t.index ["industry_id", "created_at"], name: "index_experience_posts_on_industry_id_and_created_at"
    t.index ["occupation_id", "created_at"], name: "index_experience_posts_on_occupation_id_and_created_at"
    t.index ["updated_at"], name: "index_experience_posts_on_updated_at"
    t.index ["user_id", "created_at"], name: "index_experience_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_experience_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "account_name", limit: 50, null: false
    t.string "email", limit: 255
    t.string "password_digest", limit: 255, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end
end
