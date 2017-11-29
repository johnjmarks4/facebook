class UsersController < ApplicationController
  before_action :authenticate_user!, only: :index
  skip_before_action :refresh_notifications, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  def show
    #flash message saying you have to be logged in to see profile
    @id = current_user.id
    @user = current_user
    @user_name = "#{current_user.first_name} #{current_user.last_name}"
    @like = Like.new
    @post = Post.new
    @posts = Post.users_posts(current_user.id)
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
      redirect_to users_sign_up_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
    # add code to delete cookies?
    User.find(params[:format]).destroy
    session[:user_id] = nil
    flash[:notice] = "Your account has been deleted"
    redirect_to users_sign_up_path
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
