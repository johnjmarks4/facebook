class Post < ApplicationRecord
  validates :text, length: { maximum: 1000 }
  has_many :comments, :class_name => "Post", :foreign_key => "parent_id"

  def self.users_posts(user)
    Post.where(user_id: user.id)
  end
end
