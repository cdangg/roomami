class AddColumnToChores < ActiveRecord::Migration
  def change
    remove_column :chores, :status
    add_column :chores, :status, :boolean, :default => false
  end
end
