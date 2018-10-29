class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :address_line_1
      t.string :address_line_2
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
