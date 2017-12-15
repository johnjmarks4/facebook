class Like < ApplicationRecord
  before_create :add_like
  belongs_to :user
  belongs_to :post

  def assign_post_id_from_controller(post_id)
    @post_id = post_id
  end

  def self.refresh_likes(current_user, notification_history)
    posts = Post.where(user_id: current_user)
    likes = posts.map { |post| Like.where(post_id: post.id) }
    likes.reject! { |l| notification_history.include?(l) || l.empty? }
    likes
  end

  private
  
  def add_like
    Post.update(@post_id, likes: Post.find(@post_id).likes + 1)
  end
end