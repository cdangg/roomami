class AddLatitudeToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :longitude, :float
    add_column :houses, :latitude, :float
  end
end
