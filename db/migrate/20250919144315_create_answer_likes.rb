# db/migrate/*_create_answer_likes.rb
class CreateAnswerLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :answer_likes do |t|
      t.references :user,   null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.timestamps
    end
    add_index :answer_likes, [ :user_id, :answer_id ], unique: true
  end
end
