class Variant < ApplicationRecord
  belongs_to :product
  validates :name, presence: true
  validates :variation_criteria, presence: true
end
