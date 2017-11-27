class ApplicationController < ActionController::Base
  protect_from_forgery# with: :exception
  #before_action :authenticate_user!
  before_action :refresh_notifications

  def after_sign_in_path_for(resource_or_scope)
    session[:user_id] = resource_or_scope.id
    users_index_path #replace with users show path
  end

  def refresh_notifications
    session[:notifications] = { }

    session[:notifications][:friend_requests] = FriendRequest.refresh_friend_requests(current_user)
    @notifications = session[:notifications]
  end

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end