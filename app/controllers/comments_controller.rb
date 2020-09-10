class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    binding.pry
    redirect_to root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, request_id: params[:request_id])
  end

end
