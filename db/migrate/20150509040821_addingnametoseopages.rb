class Addingnametoseopages < ActiveRecord::Migration
  def change
  	add_column :seo_pages, :name, :string
  end
end
