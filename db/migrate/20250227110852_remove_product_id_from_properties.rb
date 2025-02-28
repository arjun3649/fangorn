class RemoveProductIdFromProperties < ActiveRecord::Migration[8.0]
  def change
     remove_reference :properties, :product, foreign_key: true, index: true
  end
end
