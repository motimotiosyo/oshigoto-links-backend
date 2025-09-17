class OccupationCategory < ApplicationRecord
  belongs_to :occupation
  validates :name, :code, presence: true
end