Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :recettes
end
