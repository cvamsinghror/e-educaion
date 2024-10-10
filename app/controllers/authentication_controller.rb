class AuthenticationController < ApplicationController
skip_before_action :authenticate_request

  def login 
    @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            token = jwt_encode(user_id: @user.id)
            render json: { token: token }, status: :ok
        else 
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
  end

  def signup 
    @user = User.new(user_params)
    if @user.save
      SendWelcomeEmailJob.set(wait: 1.minute).perform_later(@user.id)
      token = jwt_encode(user_id: @user.id) 
      render json: { message: 'User created successfully, welcome email sent.', token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end
end

