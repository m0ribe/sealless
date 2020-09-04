Rails.application.routes.draw do
  devise_for :users
  root to: "requests#index"
  resources :users, only: [:edit, :update]
  resources :requests, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      get :approve
    end
    resources :comments, only: [:create]
  end
end
