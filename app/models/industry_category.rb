class IndustryCategory < ApplicationRecord
  belongs_to :industry
  validates :name, :code, presence: true
end
