class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :name
      t.boolean :status
      t.integer :house_id
      t.integer :user_id

      t.timestamps
    end
  end
end
