class AddAddressfieldsToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :address_line_1, :string
  	add_column :profiles, :zip_code, :string
  	add_column :profiles, :address_line_2, :string
  end
end
