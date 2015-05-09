json.array!(@profiles) do |profile|
  json.extract! profile, :id, :user_id, :name, :email, :claimed, :description, :blurb, :bar_id, :state, :phone_number, :law_school
  json.url profile_url(profile, format: :json)
end
