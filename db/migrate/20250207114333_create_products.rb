class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :primary_category,  limit: 100, null: false
      t.string :name,  limit: 1024, null: false
      t.string :description

      t.timestamps
    end
  end
end
