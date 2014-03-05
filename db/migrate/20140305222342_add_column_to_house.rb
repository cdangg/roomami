class AddColumnToHouse < ActiveRecord::Migration
  def change
  	add_column :houses, :bedrooms, :integer
  	add_column :houses, :bathrooms, :integer
  	add_column :houses, :description, :string
  end
end
