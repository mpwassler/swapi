class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.index :billing_address_id
      t.index :shipping_address_id
      t.integer :total
      t.string :status
      t.string :payment_status

      t.timestamps
    end
  end
end
