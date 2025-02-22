class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :primary_category
      t.text :description
      t.string :unit
      t.jsonb :more_data
      t.timestamps
    end
  end
end
