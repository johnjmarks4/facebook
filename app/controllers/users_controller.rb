class UsersController < ApplicationController
  before_action :authenticate_user!, only: :index
  skip_before_action :refresh_notifications, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Tell the UsersMailer to send a welcome email after save
        UsersMailer.welcome_email(@user).deliver_now!
 
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @browser = current_user
    @browser_name = "#{current_user.first_name} #{current_user.last_name}"
    @profile_owner = User.find(params[:id])
    @profile_owner_name = "#{@profile_owner.first_name} #{@profile_owner.last_name}"
    @like = Like.new
    @post = Post.new
    if @profile_owner == current_user
      @posts = Post.friends_posts(params[:id])
    else
      @posts = Post.users_posts(params[:id])
    end
  end

  def search
    if params[:name]
      @friends = current_user.friends
      @users = User.users_matching_name(params[:name])
    end
  end

  def list
  end

  def edit
  end

  def update
  end

  def destroy
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
