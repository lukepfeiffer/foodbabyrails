Rails.application.routes.draw do
  root to: "events#index"

  get "/search", to: "events#search"
  resources :events
end
