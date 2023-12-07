Rails.application.routes.draw do
  resources :wishlists
  resources :menus
  resources :guest_lists
  resources :funds
  resources :guest_books
  resources :photos
  devise_for :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  root "static_pages#home"

  resources :locations

  # Users show routes:
  resources :users do
    resource :guest_list, only: [:show, :update]
    resource :menu, only: [:show, :update]
    resource :wishlist, only: [:show, :update]
    resources :photos, only: [:index, :show]
    resource :guest_book, only: [:show, :update]
    resource :fund, only: [:show, :update]
  end
end
