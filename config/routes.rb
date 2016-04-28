Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'users/autocomplete_user_name'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :groups
  resources :relationships, only: [:create, :destroy]
  root to: 'static_pages#home'
  match '/help',            to: 'static_pages#help',      via: 'get'
  match '/about',           to: 'static_pages#about',     via: 'get'
  match '/contact',         to: 'static_pages#contact',   via: 'get'
  match '/notifications',   to: 'notifications#index',    via: 'get'



  #####################resturants ########################

  get 'restaurants' , to: 'restaurants#index' , as: 'restaurants_list'
  get 'restaurants/:id' , to: 'restaurants#show' , as: 'restaurant'
  post 'restaurants/:id' , to: 'restaurants#make_order' , as: 'make_order'
  ###################### orders ############################

  resources :orders do
  end
  get 'invitations', to: 'orders#invitations'


end
