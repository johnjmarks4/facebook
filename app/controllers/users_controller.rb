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
    @id = current_user.id
    @user = "#{current_user.first_name} #{current_user.last_name}"
    @like = Like.new
    @post = Post.new
    @posts = Post.users_posts(current_user)
    if !user_signed_in?
      #redirect_to '/users/sign_in'
    end
  end

  def index
    if !params[:name].nil?
      @users = User.users_matching_name(params[:name])
      if user_signed_in?
        @friends = current_user.friends
      end
    else
      redirect_to users_sign_in_path
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
