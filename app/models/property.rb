class Property < ApplicationRecord
  belongs_to :product
  validates :unit, presence: :true
  validates :name, presence: :true
  validates :description, presence: :true
end
