class Changecolumns < ActiveRecord::Migration
  def change
  	add_column :users, :vendor, :boolean, {:default => false}
  	add_column :quotes, :user_id, :integer
  end
end
