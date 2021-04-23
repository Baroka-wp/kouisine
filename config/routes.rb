Rails.application.routes.draw do
  root 'recettes#index'
  resources :users, only: [:index, :new, :create, :show, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :recettes
  resources :favorites, only: [:create, :destroy]
end
