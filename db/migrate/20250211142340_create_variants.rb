class CreateVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :variants do |t|
      t.references :products, null: false, foreign_key: true
      t.string :slug, limit: 1024
      t.string :name, limit: 1024
      t.string :variation_criteria, limit: 1024
      t.boolean :is_default

      t.timestamps
    end
  end
end
