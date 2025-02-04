class NotificationsController < ApplicationController
  before_action :authenticate_request
  
  def index
    @notifications = @current_user.notifications.order(created_at: :desc)
    render json: @notifications
  end
end