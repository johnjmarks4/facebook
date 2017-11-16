require 'devise'

class UsersController < ApplicationController
  #before_action :authenticate_user!, only: :index

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  def show
    #flash message saying you have to be logged in to see profile
    if !user_signed_in?
      #redirect_to '/users/sign_in'
    end
  end

  def index
    @users = User.users_matching_name(params[:name])
    if user_signed_in?
      @friends = current_user.friends
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
