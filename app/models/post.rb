class Post < ApplicationRecord
  validates :text, length: { maximum: 1000 }
  has_many :comments, :class_name => "Post", :foreign_key => "parent_id"

  def self.users_posts(user_id)
    Post.where(user_id: user_id)
  end

  def self.friends_posts(user_id)
    friends = []

    Friendship.where(user_id: user_id).each do |friendship|
      friends << friendship.friend_id
    end

    Friendship.where(friend_id: user_id).each do |friendship|
      friends << friendship.user_id
    end

    friends.map! do |id|
      Post.where("user_id = ? AND created_at >= ?", id, 1.month.ago)
    end

    friends.reject(&:empty?)
  end
end
