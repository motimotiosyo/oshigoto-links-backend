class QuestionLike < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: :likes_count
  validates :user_id, uniqueness: { scope: :question_id }
end
