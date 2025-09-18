class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: true
  # 質問に対して複数のいいね、ブックマーク、コメント（後で実装）
  # has_many :question_likes, dependent: :destroy
  # has_many :question_bookmarks, dependent: :destroy
  # has_many :question_comments, dependent: :destroy

  validates :body, presence: true
end
