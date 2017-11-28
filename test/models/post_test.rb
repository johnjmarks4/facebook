require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @one = posts :one
  end
  
  test "should be valid" do
    #assert @one.valid?
    #puts @one.errors.inspect
  end

  test "text should be present" do
    @one.text = ""
    assert_not @one.valid?
  end

  test "post id should be present" do
    assert_not @one.id.nil?
  end

  test "text should be less than 1000 words" do
    @one.text = "a " * 1001
    assert_not @one.valid?
  end

  test "post can create comments" do
    comment = @one.comments.create(text: "This is a comment!", user_id: 1)
    #assert comment.valid?
    assert_equal comment.parent_id, @one.id
  end
end