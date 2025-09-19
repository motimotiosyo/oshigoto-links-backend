class AddLikesCountToQuestionsAndAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :likes_count, :integer, null: false, default: 0 unless column_exists?(:questions, :likes_count)
    add_column :answers,   :likes_count, :integer, null: false, default: 0 unless column_exists?(:answers,   :likes_count)

    add_index :answers, :likes_count unless index_exists?(:answers, :likes_count)
    add_index :questions, :likes_count unless index_exists?(:questions, :likes_count)
  end
end
