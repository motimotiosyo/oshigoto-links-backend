class User < ApplicationRecord
  # パスワードハッシュ化
  has_secure_password

  # バリデーション
  validates :account_name, presence: true, length: { maximum: 50 }, 
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # リレーション
  has_many :experience_posts, dependent: :destroy
end
