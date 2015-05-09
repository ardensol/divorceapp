class CreateSeoPages < ActiveRecord::Migration
  def change
    create_table :seo_pages do |t|
      t.string :city
      t.string :state
      t.string :og_description
      t.string :slug
      t.string :image_tag

      t.timestamps null: false
    end
  end
end
