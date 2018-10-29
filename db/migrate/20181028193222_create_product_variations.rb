class CreateProductVariations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_variations do |t|
      t.string :sku
      t.string :title
      t.integer :price
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
