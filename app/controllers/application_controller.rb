class ApplicationController < ActionController::Base
  protect_from_forgery# with: :exception
  #before_action :authenticate_user!
  before_action :refresh_notifications

  def after_sign_in_path_for(resource_or_scope)
    session[:user_id] = resource_or_scope.id
    users_index_path #replace with users show path
  end

  def refresh_notifications
    session[:notifications] = { } if !session[:notifications]
    session[:notifications][:likes] = [] if !session[:notifications][:likes]
    @friend_requests = []
    @likes = []

    # Refactor these into seperate methods
    if current_user
      @friendship = Friendship.new
      session[:notifications][:friend_requests] = FriendRequest.refresh_friend_requests(current_user)
      session[:notifications][:friend_requests].each do |request|
        user = User.find(request.user_id)
        name = user.first_name + " " + user.last_name
        @friend_requests << ["#{name} added you", request.user_id]
      end

      new_likes = Like.refresh_likes(current_user, session[:notifications][:likes])
      session[:notifications][:likes] << new_likes
      if !new_likes.empty?
        new_likes.each do |like|
          like = like.first
          user = User.find(like.user_id)
          name = user.first_name + " " + user.last_name
          @likes << "#{name} liked your #{view_context.link_to 'post', posts_show_path(like.user_id)}".html_safe
        end
      end
    end
  end

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if !session[:user_id].nil?
  end
  helper_method :current_user
end