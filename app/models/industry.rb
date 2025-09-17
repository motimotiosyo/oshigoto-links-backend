class Industry < ApplicationRecord
  has_many :industry_categories, dependent: :destroy
end
