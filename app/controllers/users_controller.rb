class UsersController < ApplicationController
  before_action :authenticate_user!, only: :index
  skip_before_action :signed_in?, only: [:create]
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
        session[:user_id] = @user.id
        
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
    @posts = toggle_timeline_and_wall
  end

  def search
    @title = "Search Results"
    if params[:name]
      @friends = current_user.friends
      @users = User.find_user_named(params[:name])
    end
    render users_search_path
  end

  def list
    @title = "All Users"
    @friends = current_user.friends
    @users = User.all
    render users_search_path
  end

  def friends
    @title = "Your Friends"
    @friends = current_user.friends
    @users = @friends
    render users_search_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user_params
    @user = User.find(params[:id])

    if params[:user][:password].blank? || params[:user][:password][0..8] == "Password"
      if @user.update_without_password(user_params.except(:password, :password_confirmation))
        flash[:notice] = "Account updated"
        redirect_to user_path(@user.id)
      else
        flash[:notice] = "Update failed"
        render edit_box_registration_path(@user.id)
      end
    elsif @user.update_attributes(user_params)
      bypass_sign_in @user, scope: :user
      flash[:notice] = "Account updated"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "Update failed"
      render edit_box_registration_path(@user.id)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil
    flash[:notice] = "Your account has been deleted"
    redirect_to root_path
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

  def toggle_timeline_and_wall
    if params[:wall_setting]
      session[:wall_setting] = params[:wall_setting]
    elsif @profile_owner == current_user
      session[:wall_setting] = "timeline"
    else
      session[:wall_setting] = "wall"
    end

    Post.send "#{session[:wall_setting]}_posts", params[:id]
  end
end
