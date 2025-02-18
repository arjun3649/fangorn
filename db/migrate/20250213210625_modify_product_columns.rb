class ModifyProductColumns < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      ALTER TABLE products
        DROP COLUMN IF EXISTS slug,
        DROP COLUMN IF EXISTS variant_name,
        DROP COLUMN IF EXISTS variant_description,
        DROP COLUMN IF EXISTS variant_options,
        DROP COLUMN IF EXISTS price,
        DROP COLUMN IF EXISTS status;

      ALTER TABLE products
        ADD COLUMN IF NOT EXISTS deleted_at timestamp;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE products
        ADD COLUMN IF NOT EXISTS slug varchar,
        ADD COLUMN IF NOT EXISTS variant_name varchar,
        ADD COLUMN IF NOT EXISTS variant_description text,
        ADD COLUMN IF NOT EXISTS variant_options text,
        ADD COLUMN IF NOT EXISTS price decimal,
        ADD COLUMN IF NOT EXISTS "status" varchar;

      ALTER TABLE products
        DROP COLUMN IF EXISTS deleted_at;
    SQL
  end
end
