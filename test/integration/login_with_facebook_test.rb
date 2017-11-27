require 'test_helper'

class LoginWithFaceBookTest < Capybara::Rails::TestCase

  def setup
    @one = users :one 
  end

=begin
  test "facebook login" do
    visit root_path
    
    click_on "Sign in with Facebook", :match => :first
    mock_auth_hash
    puts current_path
    click_link "Sign in"
    page.should have_content("mockuser")


    #find('login_form').value
    #fill_in(id: 'email'), with: @one.email
    #fill_in 'input#pass', with: @one.password
  end
=end
end