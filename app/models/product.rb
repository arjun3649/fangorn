class Product < ApplicationRecord
  validates :primary_category, presence: :true
  validates :name, presence: :true
  validates :description, presence: :true
end
