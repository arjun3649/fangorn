class UpdatePropertyFields < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      ALTER TABLE properties
        DROP COLUMN IF EXISTS primary_category;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE properties
        ADD COLUMN primary_category varchar;
    SQL
  end
end