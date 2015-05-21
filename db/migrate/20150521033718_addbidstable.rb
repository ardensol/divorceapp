class Addbidstable < ActiveRecord::Migration
  def change
  	create_table :bids do |t|
      t.integer :user_id
      t.integer	:quote_id
      t.string :name
      t.string :slug
      t.integer :amount
      t.text :description
      
      t.timestamps null: false
  	end
  end
end
