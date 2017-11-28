class FriendshipsController < ApplicationController
  
  def add
    FriendRequest.create(user_id: current_user.id, 
                         friend_id: params[:friend_id],
                         user_name: "#{current_user.first_name} #{current_user.last_name}")
    redirect_back fallback_location: "/", notice: "Friend request sent"
  end

  def create
    request = FriendRequest.find_by(id: params[:format])
    Friendship.create(user_id: request.user_id, friend_id: request.friend_id)
    Friendship.create(user_id: request.friend_id, friend_id: request.user_id)
  end

  def destroy
  end
end