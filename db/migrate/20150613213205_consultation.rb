class Consultation < ActiveRecord::Migration
  def change
  	create_table :consultations do |t|
      t.string :name
      t.string :email
      t.text   :description
      
      t.timestamps null: false
  	end
  end
end
