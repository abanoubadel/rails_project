Rails.application.routes.draw do
  get 'timeline/index'

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'users/autocomplete_user_name'


  resources :users do
    member do
      get :following
    end
  end

  resources :groups
  resources :relationships, only: [:create, :destroy]
  root to: 'static_pages#index'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/notifications/json', to: 'notifications#list', via: 'get'
  match '/notifications', to: 'notifications#index', via: 'get'
  match '/notifications', to: 'notifications#update', via: 'post'

  #####################resturants ########################

  get 'restaurants', to: 'restaurants#index', as: 'restaurants_list'
  get 'restaurants/:id', to: 'restaurants#show', as: 'restaurant'
  post 'restaurants/:id', to: 'orders#create', as: 'make_order'
  get 'orders/restaurants/join/:id', to: 'restaurants#join_order', as: 'join_order'
  patch 'orders/restaurants/join/:id', to: 'orders#join_order_update'

  ###################### orders ############################

  resources :orders do
  end

  get 'invitations', to: 'orders#invitations'

  get 'timeline', to: 'users#timeline'

end
