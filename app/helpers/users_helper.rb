module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    default_url = "#{root_url}images/guest.png"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=250&d=#{CGI.escape(default_url)}"
    user_name = "#{user.first_name} #{user.last_name}"
    image_tag(gravatar_url, alt: user_name, class: "gravatar")
  end

  def find_user_by_id(id)
    User.find(id)
  end
end