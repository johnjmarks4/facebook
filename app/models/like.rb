class Like < ApplicationRecord
  before_create :add_like
  belongs_to :user
  belongs_to :post

  def assign_post_id_from_controller(post_id)
    @post_id = post_id
  end

  private
    def add_like
      Post.update(@post_id, likes: Post.find(@post_id).likes + 1)
    end
end