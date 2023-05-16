Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end

  resources :categories, module: :categories do
    resources :expenses
  end
end
