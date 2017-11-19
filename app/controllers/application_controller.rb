class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :refresh_notifications

  def after_sign_in_path_for(resource_or_scope)
    current_user
  end

  def refresh_notifications
    session[:notifications] = { }

    session[:notifications][:friend_requests] = FriendRequest.refresh_friend_requests(current_user)
    @notifications = session[:notifications]
  end
end