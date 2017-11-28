require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @one = likes :one
  end
  
  test "should be valid" do 
    #assert @one.valid?
  end
end
