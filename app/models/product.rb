class Product < ApplicationRecord
  has_many :variant, dependent: :destroy
  has_many :property, dependent: :destroy
  validates :primary_category, presence: :true
  validates :name, presence: :true
  validates :description, presence: :true
end
