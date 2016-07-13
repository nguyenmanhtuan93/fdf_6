Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :users
  resources :products, only: [:index, :show]
  resources :comments, except: [:new, :index, :show]
  resources :suggests, only: [:index, :create]
  resources :orders, only: [:index, :show, :update]
  resources :order_details, except: [:show, :new]

  namespace :admin do
    resources :users
    resources :categories
    resources :products
    resources :suggests, only: [:index, :destroy]
  end
end
