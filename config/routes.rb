Rails.application.routes.draw do

  resources :posts

  get 'posts/comment'

  as :user do

    resources :users, :only => [:new, :create, :index]

    get "/users/sign_in" => "users/sessions#new"

    post "/users/index" => "users#index"

    get "/users/sign_in" => "users/sessions#create"

    post "/users/sign_in" => "users/sessions#create"

    get "/users/sign_up" => "users/registrations#new"

    post "/users/sign_up" => "devise/registrations#new"

    root "users/sessions#create"
  end

  get "friendships/add"

  post "friendships/add"

  get "friendships/create"

  get "friendships/destroy"

  resources :users, :except => [:new, :create, :index]

  devise_for :models

  devise_for :users, :controllers => { registrations: "registrations", sessions: "sessions" }
end