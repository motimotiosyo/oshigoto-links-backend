class Question < ApplicationRecord
  # 質問はユーザーに属する
  belongs_to :user

  # 業界・職種は未選択を許可する（NULL可）
  belongs_to :industry_category,   optional: true
  belongs_to :occupation_category, optional: true

  # ベスト回答は存在しないことがあるのでNULL可
  belongs_to :accepted_answer, class_name: "Answer", optional: true

  # 質問に対して複数の回答。質問が削除されたら関連回答も削除される
  has_many :answers, dependent: :destroy

  # バリデーション。タイトル、本文、ステータスは必須。タイトルは120文字以内。
  # ステータスは "open" / "answered" / "closed" のいずれか。
  validates :title, presence: true, length: { maximum: 120 }
  validates :body,  presence: true
  validates :status_label, inclusion: { in: %w[open answered closed] }

  # スコープ。作成日時の降順。
  scope :recent, -> { order(created_at: :desc) }

  # ソート用メソッド
  def self.sorted_by(sort_param)
    case sort_param
    when "created_at"        then order(created_at: :asc)
    when "-created_at", nil  then order(created_at: :desc)
    when "updated_at"        then order(updated_at: :asc)
    when "-updated_at"       then order(updated_at: :desc)
    when "title"             then order(title: :asc)
    when "-title"            then order(title: :desc)
    else
      order(created_at: :desc)
    end
  end
end
