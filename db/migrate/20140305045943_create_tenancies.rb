class CreateTenancies < ActiveRecord::Migration
  def change
	create_table :tenancies do |t|
	  t.integer :user_id
	  t.integer :house_id
	  t.timestamps
	end
  end
end
