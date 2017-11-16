require 'devise'

class UsersController < ApplicationController
  #before_action :authenticate_user!, only: :index

  def new
    @user = User.new
  end

  def create
  end

  def show
    #flash message saying you have to be logged in to see profile
    if !user_signed_in?
      #redirect_to '/users/sign_in'
    end
  end

  def index
    @users = User.users_matching_name(params[:name])
    puts "ran1"
    puts user_session
    puts user_signed_in?
    if user_signed_in?
      puts "ran2"
      @friends = User.users_friends(current_user)
      puts @friends.inspect
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
