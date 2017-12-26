module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    default_url = "http://www.gravatar.com/avatar"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=250&d=#{CGI.escape(default_url)}"
    user_name = "#{user.first_name} #{user.last_name}"
    image_tag(gravatar_url, class: "gravatar")
  end

  def find_user_by_id(id)
    User.find(id)
  end

  def find_likers(post_id)
    likes = Like.where(post_id: post_id).to_a
    users = likes.map { |like| like.user_id }
    users.map { |user_id| User.find(user_id).first_name + " " + User.find(user_id).last_name }
  end

  def friends?(user)
    current_user.friends.include?(user)
  end

  def set_toggle_button_text
    if @profile_owner != current_user
      session[:wall_setting] == "wall" ? "users" : "wall"
    else
      session[:wall_setting] == "wall" ? "timeline" : "wall"
    end
  end
end