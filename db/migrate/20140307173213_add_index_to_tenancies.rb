class AddIndexToTenancies < ActiveRecord::Migration
  def change
    add_index :tenancies, [:user_id, :house_id], unique: true
    remove_column :tenancies, :name
  end
end
