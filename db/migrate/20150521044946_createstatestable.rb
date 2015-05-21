class Createstatestable < ActiveRecord::Migration
  def change
  	create_table :states do |t|
      t.string :name
      t.integer	:divorce_cost
      t.float :divorce_rate
      t.integer :total_divorce
      t.text :distribution_type
      t.text :divorce_law_description
      
      t.timestamps null: false
  	end
  end
end
