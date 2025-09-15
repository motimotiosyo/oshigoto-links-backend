class Experience < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :tags, length: { maximum: 10 }

  validate :validate_tag_format

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_tag, ->(tag) { where("? = ANY(tags)", tag) }

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

  private

  def validate_tag_format
    return unless tags.present?

    tags.each_with_index do |tag, index|
      if tag.blank?
        errors.add(:tags, "#{index + 1}番目のタグが空です")
      elsif tag.length > 50
        errors.add(:tags, "#{index + 1}番目のタグが50文字を超えています")
      end
    end
  end
end
