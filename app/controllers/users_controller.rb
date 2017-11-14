require 'devise'

class UsersController < ApplicationController
  #before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
  end

  def show
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
