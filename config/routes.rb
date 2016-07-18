Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  post "/rate" => "rater#create", as: "rate"
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
    resources :users do
      collection do
        match "search" => "admin#users#index",
          via: [:get, :post], as: :search
      end
    end
    resources :categories do
      collection do
        match "search" => "admin#categories#index",
          via: [:get, :post], as: :search
      end
    end
    resources :products do
      collection do
        match "search" => "admin#products#index",
          via: [:get, :post], as: :search
      end
    end
    resources :suggests, only: [:index, :destroy]
    resources :orders, only: [:index, :update, :destroy]
  end
end
