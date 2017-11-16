Rails.application.routes.draw do

  devise_for :friendships
  devise_scope :user do

    resources :users, :only => [:new, :create, :index]

    get "/users/sign_in" => "devise/sessions#new"

    post "/users/index" => "users#index"
  end

  get "friendships/add"

  get "friendships/create"

  get "friendships/destroy"

  resources :users, :except => [:new, :create, :index]

  post "users/:id" => "users#show"

  devise_for :models

  devise_for :users, :controllers => { registrations: "registrations" },
    :skip => [:friendships]
end