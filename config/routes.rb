Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  resources :users, only: [:create] do 
    resources :discover, only: :index
  end

  get "/dashboard", to: "users#show"
  get "/register", to: "users#new"
end
