class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :email
      t.string :name
      t.string :field
      t.text :description
      t.string :location

      t.timestamps null: false
    end
  end
end
