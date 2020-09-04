class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    binding.pry
  end
end
