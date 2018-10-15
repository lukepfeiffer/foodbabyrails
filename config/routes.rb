Rails.application.routes.draw do
  root to: "events#index"

  post "/search", to: "events#search"
  resources :events
end
