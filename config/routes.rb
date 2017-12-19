Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                    registrations: "users/registrations",
                                    sessions: "users/sessions" }

  as :user do
    root 'users/registrations#new'
  end

  resources :users, except: [:edit]
  get 'users/list'
  post 'users/index'
  get 'users/friends'
  get 'users/search'
  post 'users/search'

  resources :comments, only: [:new, :create]

  resources :posts
  get 'posts/comment'
  post 'posts/comment'
  post 'posts/like'

  resources :friendships, only: [:new, :create, :destroy]
  post 'friendships/new'
  get 'friendships/delete_request'
  post 'friendships/delete_request'
end