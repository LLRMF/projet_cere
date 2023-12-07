json.extract! guest_list, :id, :user_id, :name, :created_at, :updated_at
json.url guest_list_url(guest_list, format: :json)
