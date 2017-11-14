Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    #root :to => redirect("users/sign_in")
  end
end