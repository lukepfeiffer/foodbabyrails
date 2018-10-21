Rails.application.routes.draw do
  root to: "events#index"

  resources :events
  resources :users

  post "/search", to: "events#search"
  post '/sign_in', to: 'sessions#create'

  delete '/sign_out', to: 'sessions#destroy'

  get "/sign_in", to: "pages#sign_in"
end
