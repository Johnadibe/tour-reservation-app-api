Rails.application.routes.draw do
  # get 'reservations/index'
  # get 'reservations/show'
  # get 'reservations/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index] do
          resources :reservations, only: [:index, :show, :new, :create]
      end
    end
  end
end
