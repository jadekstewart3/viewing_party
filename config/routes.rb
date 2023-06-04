Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  resources :users, only: [:new, :create] do 
    resources :discover, only: :index
    resources :movies, only: [:index, :show] do
     resources :parties, only: [:new, :create]
    end
  end

  get "/dashboard", to: "users#show"
  get "/register", to: "users#new"
  get "/login", to: "users#login_form"
  post "/login", to: "users#login_user"
  get "/logout", to: "users#logout"
end
