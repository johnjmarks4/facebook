class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "Your post was too long"
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def comment
  end

  private

    def post_params
      params.require(:post).permit(:text, :user_id)
    end
end
