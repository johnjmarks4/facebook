require "test_helper"

describe StaticPagesController do
  it "should get about" do
    get static_pages_about_url
    value(response).must_be :success?
  end

end
