class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many   :answer_likes, dependent: :destroy
  validates :body, presence: true
end
