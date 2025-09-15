class ExperiencePost < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { maximum: 120 }
  validates :body, presence: true
  validates :user_id, presence: true
  validates :industry_id, presence: true
  validates :occupation_id, presence: true
  validates :status, presence: true, inclusion: { in: %w[draft published] }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }

  # Class methods
  def self.sorted_by(sort_param)
    case sort_param
    when "created_at"
      order(created_at: :asc)
    when "-created_at", nil
      order(created_at: :desc)
    when "updated_at"
      order(updated_at: :asc)
    when "-updated_at"
      order(updated_at: :desc)
    when "title"
      order(title: :asc)
    when "-title"
      order(title: :desc)
    else
      order(created_at: :desc)
    end
  end
end
