class CommentsController < ApplicationController
  
  def new
    redirect_to comments_path comment: { text: params[:text], user_id: params[:user_id], parent_id: params[:post_id] }
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.poster_name = User.users_name(params[:comment][:user_id])
    if @comment.save
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "Your comment was too long"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :parent_id, :poster_name, :likes)
  end
end
