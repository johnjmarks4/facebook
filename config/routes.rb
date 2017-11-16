Rails.application.routes.draw do

  devise_scope :user do

    resources :users, :only => [:new, :create, :index]

    get "/users/sign_in" => "users/sessions#new"

    post "/users/index" => "users#index"

    get "/users/sign_in" => "users/sessions#create"

    post "/users/sign_in" => "users/sessions#create"
  end

  get "friendships/add"

  get "friendships/create"

  get "friendships/destroy"

  resources :users, :except => [:new, :create, :index]

  #post "users/:id" => "users#show"

  devise_for :models

  devise_for :users, :controllers => { registrations: "registrations", sessions: "sessions" }
end