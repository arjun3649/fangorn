class AddProductIdtoProperties < ActiveRecord::Migration[8.0]
  def change
    add_reference :properties, :product, null: false, foreign_key: true
  end
end
