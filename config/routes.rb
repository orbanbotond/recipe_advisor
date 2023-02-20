Rails.application.routes.draw do
  root "home#index"

  resources :home_ingredients, only: [:destroy, :create, :new]
  resources :search, only: :index
  resources :receipts, only: :show
end
