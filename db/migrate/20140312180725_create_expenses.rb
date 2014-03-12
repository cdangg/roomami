class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
			t.string   "description"
			t.integer  "house_id"
			t.integer  "user_id"
			t.boolean  "status",     default: false
			t.float    "amount"
			t.integer  "roommates"
      t.timestamps
    end
  end
end
