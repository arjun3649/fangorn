class Product < ApplicationRecord
  has_many :variants, dependent: :destroy
  has_many :product_properties, dependent: :destroy
  has_many :properties, through: :product_properties
  validates :primary_category, presence: :true
  validates :name, presence: :true
  validates :description, presence: :true
end
