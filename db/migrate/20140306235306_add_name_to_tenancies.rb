class AddNameToTenancies < ActiveRecord::Migration
  def change
    add_column :tenancies, :name, :string
  end
end
