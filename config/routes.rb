Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :country, only: [:index, :show]

  # Defines the root path route ("/")
  root 'country#index'
end
