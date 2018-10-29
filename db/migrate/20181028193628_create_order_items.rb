class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order, foreign_key: true
      t.integer :quantity
      t.belongs_to :product_variation, foreign_key: true
      t.integer :price
      t.integer :total

      t.timestamps
    end
  end
end
