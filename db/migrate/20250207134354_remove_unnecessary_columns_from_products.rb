class RemoveUnnecessaryColumnsFromProducts < ActiveRecord::Migration[8.0]
  def change
  remove_column :products, :slug
  remove_column :products, :variant_name
  remove_column :products, :image_path
  remove_column :products, :product_status
  remove_column :products, :category_id
  end
end
