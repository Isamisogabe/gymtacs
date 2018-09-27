Rails.application.routes.draw do
  get 'relationships/create'

  get 'relationships/destroy'

  get 'items/index'

  get 'items/edit'

  get 'items/create'

  get 'items/destroy'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  #get 'toppages/index'
  #get 'settings/profile'
  #get 'settings/account'
  #get 'settings/account/custom_image'
  
  
  # ログイン・ログアウト関係
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # トップページ関係
  get 'trend', to: 'toppages#trend'
  get 'timeline', to: 'toppages#timeline'
  get 'favorite', to: 'toppages#favorite'
  get 'pick', to: 'toppages#pick'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  get 'login' , to: 'sessions#new'
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  
  get  'settings', to: 'users#settings'
  put 'settings', to: 'users#update'
  get 'account', to: 'users#account'
  put 'account', to: 'users#account'
  
  resources :items
  #resources :settings, only: [:update, :delete]
  resources :relationships, only: [:create, :destroy]
  
end
