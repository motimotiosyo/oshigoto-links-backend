class Answer < ApplicationRecord
  belongs_to :question, counter_cache: true
  belongs_to :user

  validates :body, presence: true
end
