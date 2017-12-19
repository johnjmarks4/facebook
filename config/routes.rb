Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                    registrations: "users/registrations",
                                    sessions: "users/sessions" }

  as :user do
    root 'users/registrations#new'
  end

  get 'users/list'
  post 'users/index'
  get 'users/friends'
  get 'users/search'
  post 'users/search'

  get 'posts/comment'
  post 'posts/comment'
  post 'posts/like'

  post 'friendships/new'
  post 'friendships/delete_request'

  resources :posts
  resources :users,       except: [:edit]
  resources :comments,    only:   [:new, :create]
  resources :friendships, only:   [:new, :create, :destroy]
end