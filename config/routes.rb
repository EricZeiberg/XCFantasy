Blog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  resources :posts
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users/sign_up' => 'devise/registrations#new'
  end
  # get '/members', :to => "member#index"
  # get '/member/new', :to => 'member#new'
  # get '/member/:id', :to => 'member#show'
  # post '/member/create', :to => 'member#create'
  #
  # get '/results', :to => "result#index"
  # get '/member/:id/newResult', :to => "result#new"
  # get '/result/:id', :to => 'result#show'
  # post '/result/create', :to => 'result#create'
  #
  # get '/meets', :to => 'meet#index'
  # get '/meet/new', :to => 'meet#new'
  # get '/meet/:id', :to => 'meet#show'
  # post '/meet/create', :to => 'meet#create'

  get '/meets', :to => 'races#index'
  get '/meet/new', :to => 'races#new'
  get '/meet/:id', :to => 'races#get'
  get '/meet/:id/run', :to => 'races#run'

  post '/meet/create', :to => "races#create"
  post 'meet/:id/update', :to => 'races#update'
  post '/meet/:id/runUpdate', :to => 'races#runUpdate'

  get '/leaderboard', :to => "users#index"
  get '/user/:name', :to => "users#view"
  get '/user/:name/pred/:raceid', :to => "users#getPred"

end
