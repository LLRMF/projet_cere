json.extract! wishlist, :id, :user_id, :name, :description, :created_at, :updated_at
json.url wishlist_url(wishlist, format: :json)
