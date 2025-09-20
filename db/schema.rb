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

ActiveRecord::Schema[7.2].define(version: 2025_09_19_194022) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "answer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_likes_on_answer_id"
    t.index ["user_id", "answer_id"], name: "index_answer_likes_on_user_id_and_answer_id", unique: true
    t.index ["user_id"], name: "index_answer_likes_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.index ["likes_count"], name: "index_answers_on_likes_count"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

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

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.integer "position", default: 0, null: false
    t.index ["code"], name: "index_industries_on_code", unique: true
    t.index ["name"], name: "index_industries_on_name"
    t.index ["position"], name: "index_industries_on_position"
  end

  create_table "industry_categories", force: :cascade do |t|
    t.bigint "industry_id", null: false
    t.string "name", null: false
    t.string "code", null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id", "code"], name: "idx_indcat_industry_code", unique: true
    t.index ["industry_id", "position"], name: "index_industry_categories_on_industry_id_and_position"
    t.index ["industry_id"], name: "index_industry_categories_on_industry_id"
  end

  create_table "occupation_categories", force: :cascade do |t|
    t.bigint "occupation_id", null: false
    t.string "name", null: false
    t.string "code", null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occupation_id", "code"], name: "idx_occucat_occupation_code", unique: true
    t.index ["occupation_id", "position"], name: "index_occupation_categories_on_occupation_id_and_position"
    t.index ["occupation_id"], name: "index_occupation_categories_on_occupation_id"
  end

  create_table "occupations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.integer "position", default: 0, null: false
    t.index ["code"], name: "index_occupations_on_code", unique: true
    t.index ["name"], name: "index_occupations_on_name"
    t.index ["position"], name: "index_occupations_on_position"
  end

  create_table "question_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_likes_on_question_id"
    t.index ["user_id", "question_id"], name: "index_question_likes_on_user_id_and_question_id", unique: true
    t.index ["user_id"], name: "index_question_likes_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "industry_id", null: false
    t.bigint "occupation_id", null: false
    t.string "title", limit: 120, null: false
    t.text "body", null: false
    t.string "status_label", limit: 16, null: false
    t.bigint "accepted_answer_id"
    t.integer "answers_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.datetime "last_answered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "industry_category_id"
    t.bigint "occupation_category_id"
    t.integer "likes_count", default: 0, null: false
    t.index ["industry_category_id", "status_label", "created_at"], name: "idx_q_indcat_status_created"
    t.index ["industry_category_id"], name: "index_questions_on_industry_category_id"
    t.index ["industry_id", "status_label", "created_at"], name: "idx_questions_industry_status_created"
    t.index ["industry_id"], name: "index_questions_on_industry_id"
    t.index ["likes_count"], name: "index_questions_on_likes_count"
    t.index ["occupation_category_id", "status_label", "created_at"], name: "idx_q_occucat_status_created"
    t.index ["occupation_category_id"], name: "index_questions_on_occupation_category_id"
    t.index ["occupation_id", "status_label", "created_at"], name: "idx_questions_occupation_status_created"
    t.index ["occupation_id"], name: "index_questions_on_occupation_id"
    t.index ["status_label", "updated_at"], name: "index_questions_on_status_label_and_updated_at"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "account_name", limit: 50, null: false
    t.string "email", limit: 255
    t.string "password_digest", limit: 255, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "answer_likes", "answers"
  add_foreign_key "answer_likes", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "industry_categories", "industries"
  add_foreign_key "occupation_categories", "occupations"
  add_foreign_key "question_likes", "questions"
  add_foreign_key "question_likes", "users"
  add_foreign_key "questions", "industries"
  add_foreign_key "questions", "industry_categories"
  add_foreign_key "questions", "occupation_categories"
  add_foreign_key "questions", "occupations"
  add_foreign_key "questions", "users"
end
