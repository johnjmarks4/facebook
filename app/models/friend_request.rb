class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def self.refresh_friend_requests(current_user)
    FriendRequest.where(friend_id: current_user.id)
  end
end