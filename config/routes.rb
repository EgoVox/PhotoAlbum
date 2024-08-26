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
      post 'create_shareable_link'
    end

    # Shareable links routes
    resources :shareable_links, only: [:show], param: :token

    # Photos routes nested within albums
    resources :photos, only: [:create, :edit, :destroy, :update]

    # Collection routes (apply to the entire collection of albums)
    collection do
      get 'private_albums'
      post 'unlock_private_albums'
    end

    # Member routes (apply to individual albums)
    member do
      post "edit_inline"
      get 'edit_photos'
      delete 'delete_photos', to: 'albums#delete_photos'
    end
  end
end
