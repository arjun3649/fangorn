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
        ADD COLUMN created_by uuid,
        ADD COLUMN deleted_at timestamp;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE products
        ADD COLUMN slug varchar,
        ADD COLUMN variant_name varchar,
        ADD COLUMN variant_description text,
        ADD COLUMN variant_options text,
        ADD COLUMN price decimal,
        ADD COLUMN status varchar;

      ALTER TABLE products
        DROP COLUMN IF EXISTS created_by,
        DROP COLUMN IF EXISTS deleted_at;
    SQL
  end
end
