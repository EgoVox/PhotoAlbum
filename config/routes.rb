Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "albums#index"

  resources :albums do
    resources :photos, only: [:create, :destroy]

  member do
    post "edit_inline"
    get 'edit_photos' # Route pour afficher la page d'édition des photos
    delete 'delete_photos', to: 'albums#delete_photos' # Route pour supprimer les photos sélectionnées
    end
  end
end
