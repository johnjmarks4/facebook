require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase

  def setup
    @one = friend_requests :one
    @user_one = users :one
    @user_two = users :two
  end
  
  test "should be valid" do
    #assert @one.valid?
  end

  test "user can create friend request" do
    #friend_request = @user_one.friends.create(friend_id: @user_two.id)
    #assert friend_request.valid?
  end
end