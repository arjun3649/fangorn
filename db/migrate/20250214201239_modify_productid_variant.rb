class ModifyProductidVariant < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      ALTER TABLE variants
        RENAME COLUMN products_id TO product_id;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE variants
        RENAME COLUMN product_id TO products_id;
    SQL
  end
end
