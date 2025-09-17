class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.references :user,       null: false, foreign_key: true
      t.string     :title,      null: false, limit: 120
      t.text       :body,       null: false
      t.references :industry,   null: false, foreign_key: true
      t.references :occupation, null: false, foreign_key: true

      # open | answered | closed
      t.string  :status_label, null: false, limit: 16

      # ベストアンサー
      t.bigint  :accepted_answer_id

      # カウンタ
      t.integer :answers_count,  null: false, default: 0
      t.integer :likes_count,    null: false, default: 0
      t.integer :comments_count, null: false, default: 0

      t.datetime :last_answered_at

      # timestamps を now() 初期値で
      t.datetime :created_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :updated_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    add_index :questions, [ :status_label, :updated_at ]
    add_index :questions, [ :industry_id, :status_label, :created_at ],   name: "idx_questions_industry_status_created"
    add_index :questions, [ :occupation_id, :status_label, :created_at ], name: "idx_questions_occupation_status_created"
    # accepted_answer_id の外部キーはanswers作成後に追加
  end
end
