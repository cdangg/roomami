class AddFieldToUser < ActiveRecord::Migration
  def change
    remove_column :users, :phone_number, :integer

    add_column :users, :phone_number, :string
  end
end
