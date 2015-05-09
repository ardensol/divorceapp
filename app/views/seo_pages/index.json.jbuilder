json.array!(@seo_pages) do |seo_page|
  json.extract! seo_page, :id, :city, :state, :og_description, :slug, :image_tag
  json.url seo_page_url(seo_page, format: :json)
end
