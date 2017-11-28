require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @one = posts :one
    @user = users :one
  end
  
  test "should be valid" do
    #assert @one.valid?
  end

  test "text should be present" do
    @one.text = ""
    assert_not @one.valid?
  end

  test "post id should be present" do
    assert_not @one.id.nil?
  end
end