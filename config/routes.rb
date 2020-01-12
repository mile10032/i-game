Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index" 
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new,:create,:edit,:update] do
    resources :messages, only: [:index,:create]
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
end
