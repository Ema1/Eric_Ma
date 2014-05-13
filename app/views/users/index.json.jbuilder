json.array!(@users) do |user|
  json.extract! user, :username, :email, :location
  json.url user_url(user, format: :json)
end