require "test_helper"

describe CommentsController do
  it "should get new" do
    get comments_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get comments_create_url
    value(response).must_be :success?
  end

end
