Rails.application.routes.draw do

  # Resources
  resources :images, only: [:new, :create, :destroy]
  resources :articles do
    get 'published', on: :collection #view and scope
    put 'unpublish', on: :member # action
    post 'publish', on: :member # action
    get 'prepare_publish', on: :member # set tags and release date
  end

  # Devise
  devise_for :users

  as :user do
    get '/auth/login'          => "devise/sessions#new", as: :login
    post '/auth/login'          => "devise/sessions#create"
    get '/auth/logout'         => "devise/sessions#destroy", as: :logout
    get '/auth/reset_password' => "devise/passwords#new", as: :reset_password
    post '/auth/reset_password' => "devise/passwords#create"
    get '/auth/unlock_account' => "devise/unlocks#new", as: :unlock_account
    post '/auth/unlock_account' => "devise/unlocks#create"
  end

  authenticated :user do
    root to: 'articles#index', as: :authenticated_root
  end

  # App root
  root to: redirect('/auth/login')

end
