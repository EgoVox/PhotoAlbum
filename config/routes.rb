Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route
  root "albums#index"

  # Albums routes
  # resources :albums, only: [:index, :show, :edit, :update]
  resources :albums do
    member do
      post 'add_photos'
    end
    # Photos routes nested within albums
    resources :photos, only: [:create, :edit, :destroy]

    # Collection routes (apply to the entire collection of albums)
    collection do
      get 'private_albums' # Route to display the private albums form
      post 'unlock_private_albums' # Route to unlock private albums
    end

    # Member routes (apply to individual albums)
    member do
      post "edit_inline" # Route for inline editing of an album
      get 'edit_photos' # Route to display the photo editing page
      delete 'delete_photos', to: 'albums#delete_photos' # Route to delete selected photos
    end
  end
end
