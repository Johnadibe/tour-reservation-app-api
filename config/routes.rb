Rails.application.routes.draw do
  # get 'reservations/index'
  # get 'reservations/show'
  # get 'reservations/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :new,:show] do
        resources :tours, only: [:index, :create, :new,:show]do 
          resources :reservations, only: [:index, :create, :new,:show]
        end 
      end
    end
end
