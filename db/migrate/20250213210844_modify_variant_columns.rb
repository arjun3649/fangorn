class ModifyVariantColumns < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      ALTER TABLE variants
        ADD COLUMN created_by uuid,
        ADD COLUMN deleted_at timestamp;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE variants
      ALTER TABLE products
        DROP COLUMN IF EXISTS created_by,
        DROP COLUMN IF EXISTS deleted_at;
    SQL
  end
end
