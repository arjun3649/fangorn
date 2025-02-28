class CreateProductProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :product_properties do |t|
      t.references :product, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.string :value
      t.string :remarks

      t.timestamps
    end
  end
end
