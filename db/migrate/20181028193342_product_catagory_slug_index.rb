class ProductCatagorySlugIndex < ActiveRecord::Migration[5.1]
  def change
  	add_index :catagories, :slug
  	add_index :products, :slug
  end
end
