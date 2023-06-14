Rails.application.routes.draw do
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :index]
      post "/login", to: "users#login"
      get "/me", to: "users#me"
      resources :tours, except: [:new, :edit]
    end
  end
end
