json.extract! photo, :id, :user_id, :image_data, :created_at, :updated_at
json.url photo_url(photo, format: :json)
