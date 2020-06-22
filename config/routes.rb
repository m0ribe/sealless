Rails.application.routes.draw do
  devise_for :users
  root "requests#index"
  resources :users, only: [:edit, :update]
end
