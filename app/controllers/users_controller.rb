class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:show, :destroy]

    def index
        @users = User.page(params[:page]).per(10)
        
        render json: {
          users: @users,
          meta: {
            total_pages: @users.total_pages,
            current_page: @users.current_page,
            next_page: @users.next_page,
            prev_page: @users.prev_page,
            total_count: @users.total_count
          }
        }
      end
    

    def show
        render json: @user, status: :ok
    end

    def create 
        @user = User.new(user_params)
        if @user.save
          SendWelcomeEmailJob.set(wait: 1.minute).perform_later(@user.id)
          token = jwt_encode(user_id: @user.id)
          render json: { message: 'User created successfully, welcome email sent.', token: token }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

        def update
            unless @user.update(user_params)
                render json: { errors: @user.errors.full_messages },
                status: :unprocessable_entity
            end  
        end

        def destroy
            @user.destroy
        end

        private

        def user_params
            params.require(:user).permit(:name, :username, :email, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end
    end
