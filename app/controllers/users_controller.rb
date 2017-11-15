require 'devise'

class UsersController < ApplicationController
  #before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
  end

  def show
    if !user_signed_in?
      redirect_to '/users/sign_in'
    end
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
