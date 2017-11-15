Rails.application.routes.draw do
  get 'friendships/add'

  get 'friendships/create'

  get 'friendships/destroy'

  get 'friends/add'

  get 'friends/create'

  get 'friends/destroy'

  devise_for :models
  devise_for :users

  resources :users

  devise_scope :user do
    #root :to => redirect("users/sign_in")
  end

  root "users#show"
end