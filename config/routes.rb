Rails.application.routes.draw do
  root to: "events#index"

  resources :events
  resources :users

  post "/search", to: "events#search"
  post '/sign_in', to: 'sessions#create'

  delete '/sign_out', to: 'sessions#destroy'

  get "/sign_in", to: "pages#sign_in"
  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"
  get "/render_details", to: "events#render_details"
end
