class CommentsController < ApplicationController
    before_action :authenticate_request
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params.merge(user: current_user))
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  