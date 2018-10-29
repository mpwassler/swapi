class UpdateUserRoleAndName < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :fist_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :role, :string
  	remove_column :users, :name
  end
end
