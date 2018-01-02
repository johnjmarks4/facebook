class ApplicationController < ActionController::Base
  protect_from_forgery# with: :exception
  before_action :authenticate_user!
  before_action :signed_in?
  before_action :refresh_notifications

  def after_sign_in_path_for(resource_or_scope)
    session[:user_id] = resource_or_scope.id
    user_path(current_user.id)
  end

  def refresh_notifications
    session[:notifications] = { } if !session[:notifications]
    session[:notifications][:likes] = [] if !session[:notifications][:likes]

    if current_user
      @friendship = Friendship.new
      @friend_requests = find_friend_requests
      @names, @likes = [], []
      find_likes.each do |name_and_like|
        @names << name_and_like[0]
        @likes << name_and_like[1]
      end
    end
  end

  private

  def signed_in?(scope=nil)
    [scope || Devise.mappings.keys].flatten.any? do |_scope|
      if !warden.authenticate?(scope: _scope)
        flash[:notice] = "You must be signed in to view that page"
        redirect_to root_path
      end
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if !session[:user_id].nil?
  end
  helper_method :current_user

  def find_friend_requests
    session[:notifications][:friend_requests] = FriendRequest.refresh_friend_requests(current_user)
    session[:notifications][:friend_requests].map do |request|
      user = User.find(request.user_id)
      name = user.first_name + " " + user.last_name
      ["#{name} added you", request.user_id, request.id]
    end
  end

  def find_likes
    new_likes = Like.refresh_likes(current_user.id, session[:notifications][:likes])
    session[:notifications][:likes] << new_likes

    if !new_likes.empty?
      new_likes.map do |like|
        user = User.find(like.user_id)
        name = user.first_name + " " + user.last_name
        [name, "#{view_context.link_to 'post', post_path(like.post_id)}"]
      end
    end
  end
end