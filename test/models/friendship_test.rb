require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

  def setup
    @one = friendships :one
    @user_one = users :one
    @user_two = users :two
  end
  
  test "should be valid" do
    #assert @one.valid?
  end

  test "user should be able to create friendship" do
    friendship = @user_one.friendships.create(friend_id: @user_two.id)
    assert friendship.valid?
  end
end