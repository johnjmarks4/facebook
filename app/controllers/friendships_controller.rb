class FriendshipsController < ApplicationController
  
  def add
    if FriendRequest.find_by(user_id: current_user.id, friend_id: params[:friend_id]) ||
       FriendRequest.find_by(user_id: params[:friend_id], friend_id: current_user.id)

      redirect_back fallback_location: "/", notice: "Friend request already pending"
    else
      FriendRequest.create(user_id: current_user.id, 
                           friend_id: params[:friend_id],
                           user_name: "#{current_user.first_name} #{current_user.last_name}")
      redirect_back fallback_location: "/", notice: "Friend request sent"
    end
  end

  def create
    friendship_params

    one = Friendship.new(user_id: current_user.id, friend_id: params[:friendship][:friend_id])
    two = Friendship.new(user_id: params[:friendship][:friend_id], friend_id: current_user.id)

    if one.save && two.save
      request = FriendRequest.find_by(user_id: params[:friendship][:friend_id], friend_id: current_user.id)
      if request
        request.destroy
      end
    end
  end

  def destroy
  end

  def delete_request
    FriendRequest.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end