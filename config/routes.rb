Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :weathers, only: [:index]

      resources :users, only: [:create]

      resources :sessions, only: [:create]

      resources :road_trip, only: [:create]

      resources :books, only: [:create]
    end
  end
end
