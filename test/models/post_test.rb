require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @one = posts :one
  end
  
  test "should be valid" do
    puts @one.inspect
    assert @one.valid?
  end

  test "text should be present" do
    @one.text = ""
    assert_not @one.valid?
  end

  test "post id should be present" do
    assert_not @one.id.nil?
  end

  test "order should be most recent" do
  end
end