class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def assign_post_id_from_controller(post_id)
    @post_id = post_id
  end

  def self.refresh_likes(current_user_id, notification_history)
    posts = Post.where(poster_id: current_user_id)
    likes = posts.map { |post| Like.where(post_id: post.id) }.flatten
  end
end