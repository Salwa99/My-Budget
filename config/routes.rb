Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end

  root 'home#index'

  resources :categories do
    resources :expenses, only: %i[index create new]
  end

  resources :expenses, only: %i[edit update destroy]
end
