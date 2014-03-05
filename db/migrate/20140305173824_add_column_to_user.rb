class AddColumnToUser < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :hometown, :string
  	add_column :users, :phone_number, :integer
  	add_column :users, :bio, :string
  	add_column :users, :interests, :string

  end
end
