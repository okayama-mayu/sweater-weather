Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :weathers, only: [:index]

      resources :users, only: [:create]

      resources :sessions, only: [:create]

      resources :road_trip, only: [:create]

      get '/book-search', to: 'books#create'
    end
  end
end
