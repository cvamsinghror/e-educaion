class FollowsController < ApplicationController
  before_action :authenticate_request


  def index
    @follows = @current_user.follows
    render json: @follows, status: :ok
end
  # Follow a user
  def create
    followed_user = User.find(params[:followed_id])
    current_user.follows.create(followed: followed_user)
    
    render json: { message: "Now following #{followed_user.username}" }, status: :created
  end

  # Unfollow a user
  def destroy
    followed_user = User.find(params[:followed_id])
    current_user.follows.find_by(followed: followed_user)&.destroy
    
    render json: { message: "Unfollowed #{followed_user.username}" }, status: :ok
  end
end