class CreateQuestionLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :question_likes do |t|
      t.references :user,     null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.timestamps
    end
    add_index :question_likes, [ :user_id, :question_id ], unique: true
  end
end
