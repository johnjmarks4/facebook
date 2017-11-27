require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @one = users :one
  end

  test "should be valid" do
    assert @one.valid?
  end

  test "email should be present" do
    @one.email = ""
    assert_not @one.valid?
  end

  test "password should be present" do
    @one.password = ""
    assert_not @one.valid?
  end

  test "user can create posts" do
    @one.posts.create(text: "This is a post!")
    assert_not_empty Post.where(text: "This is a post!")
  end
end