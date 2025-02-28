class Property < ApplicationRecord
  has_many :product_properties
  has_many :products, through: :product_properties
  validates :unit, presence: :true
  validates :name, presence: :true
  validates :description, presence: :true
end
