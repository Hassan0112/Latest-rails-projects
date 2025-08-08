Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end
  
  root "home#index"
  get  '/payments/new',    to: 'payments#new'
  post '/payments/create', to: 'payments#create'
  post '/webhooks/stripe', to: 'webhooks#stripe'

   resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  # for order or cart item routes
  resources :cart_items, only: [:create, :destroy]
  resource :cart, only: [:show]
  resources :orders, only: [:index, :create, :show]
  resources :products

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :listings

  devise_for :users

  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
