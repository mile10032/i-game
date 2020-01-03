Rails.application.routes.draw do
  devise_for :users
  root to: "top#index" 
  resources :top,only:[:chat]do
    collection do
      get "chat"
    end
  end
  resources :users, only: [:edit, :update]
end
