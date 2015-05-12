class AddScrapeurlToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :scrape_url, :string
  end
end
