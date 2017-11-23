Rails.application.routes.draw do

  #resources :posts

  get 'posts/comment' => 'posts#comment'

  post 'posts/comment' => "posts#comment"

  get 'user/timeline', to: 'posts#index', as: :timeline

  get 'posts/create' => "posts#create"

  post 'posts/create' => "posts#create"

  get 'posts/new'

  get 'posts/edit'

  get 'posts/show'

  post 'posts/show'

  get 'posts/update'

  get 'posts/like'

  post 'posts/like'

  as :user do

    resources :users, :only => [:new, :create, :index]

    get "/users/sign_in" => "users/sessions#new"

    post "/users/index" => "users#index"

    get "/users/sign_in" => "users/sessions#create"

    post "/users/sign_in" => "users/sessions#create"

    get "/users/sign_up" => "users/registrations#new"

    post "/users/sign_up" => "devise/registrations#new"

    get '/users/auth/:provider', to: 'users/sessions#create'

    get '/users/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'

    get 'auth/failure', to: redirect('/')

    get 'signout', to: 'users/sessions#destroy', as: 'signout'

    #delete 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session

    root "users/sessions#create"
  end

  get "friendships/add"

  post "friendships/add"

  get "friendships/create"

  get "friendships/destroy"

  resources :users, :except => [:new, :create, :index]

  devise_for :models

  devise_for :users, :controllers => { registrations: "registrations", sessions: "sessions", omniauth_callbacks: "users/omniauth_callbacks" }
end