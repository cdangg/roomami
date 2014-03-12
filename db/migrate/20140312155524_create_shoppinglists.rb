class CreateShoppinglists < ActiveRecord::Migration
  def change
    create_table :shoppinglists do |t|
      t.string :name
      t.boolean :status, :default => false
      t.integer :house_id
      t.integer :user_id
      t.timestamps
    end
  end
end
