class PostsController < ApplicationController
    before_action :authenticate_request

    
   
  def index
    @posts = Post.all
    render json: @posts, include: { comments: { only: %i[id body] } }
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, include: { comments: { only: %i[id body] } }
  end


    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
  