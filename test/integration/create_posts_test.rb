require 'test_helper'

class CreatePostsTest < Capybara::Rails::TestCase

=begin
test "poster name should automatically fill in" do
  get posts_create_url
  post = one.posts.create(text: "This is a post!")
  assert_equal post.poster_name, one.first_name + + one.last_name
end
=end

end