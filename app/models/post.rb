class Post < ApplicationRecord
  validates :text, length: { maximum: 1000 }

  def self.users_posts(user)
    Post.where(user_id: user.id)
  end
end
