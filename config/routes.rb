Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

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


  root to: 'static_pages#index'

  ####################static pages ##########################

  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  #####################resturants ########################

  get 'restaurants' , to: 'restaurants#index' , as: 'restaurants_list'
  get 'restaurants/:id' , to: 'restaurants#show' , as: 'restaurant'
  post 'restaurants/:id' , to: 'restaurants#make_order' , as: 'make_order'
  ###################### orders ############################

  resources :orders


end
