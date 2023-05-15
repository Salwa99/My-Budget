Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end

  resources :categories do
    resources :expenses, only: %i[index create new], module: :categories
  end

  resources :expenses, only: %i[edit update destroy]
end
