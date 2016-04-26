SampleApp::Application.routes.draw do
  ###################user routes######################

  get 'users/autocomplete_user_name'

  devise_for :users, :controllers => {
      :omniauth_callbacks => "user/omniauth_callbacks",
      :registrations => "user/registrations",
      :sessions => "user/sessions"
  }

  resources :users , only:[:show,:index ] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]


  root to: 'static_pages#index'

  ####################static pages ##########################

  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  #####################resturants ########################

  get 'restaurants' , to: 'restaurants#index' , as: 'restaurants_list'
  get 'restaurants/:id' , to: 'restaurants#show' , as: 'restaurant'
  post 'restaurants/:id' , to: 'restaurants#make_order' , as: 'make_order'

end
