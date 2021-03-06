class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.poster_name = User.find_name(params[:post][:poster_id])
    if @post.save
      redirect_back(fallback_location: user_path(current_user.id))
    else
      flash[:notice] = "Your post was too long"
    end
  end

  def index
    @users_posts = Post.users_posts(current_user.id)
    @friends_posts = Post.friends_posts(current_user.id)
  end

  def show
    @posts = [Post.find(params[:id])]
  end

  def edit
  end

  def update
  end

  def like
    post = Post.find(params[:post_id])
    Post.update(post.id, number_of_likes: post.number_of_likes + 1)
    like = Like.new(post_id: params[:post_id], user_id: params[:user_id])
    like.assign_post_id_from_controller(params[:post_id])
    like.save

    redirect_back(fallback_location: user_path(current_user.id))
  end

  def delete
  end

  private

  def post_params
    params.require(:post).permit(:text, :wall_id, :poster_id, :parent_id, :poster_name, :number_of_likes)
  end
end
