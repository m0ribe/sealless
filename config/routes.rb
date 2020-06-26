Rails.application.routes.draw do
  devise_for :users
  root to: "requests#index"
  resources :users, only: [:edit, :update]
  resources :requests, only: [:index, :new, :create] do
    resources :admissions, only: [:create]
  end
end
