Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "albums#index"

  resources :albums do
    resources :photos, only: [:create, :destroy]
  end

  post 'albums/:id/edit_inline', to: 'albums#edit_inline', as: 'edit_inline_album'
end
