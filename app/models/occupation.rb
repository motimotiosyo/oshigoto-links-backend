class Occupation < ApplicationRecord
  has_many :occupation_categories, dependent: :destroy
end
