class EnrollmentsController < ApplicationController

    def index
        enrollments = current_user.enrollments
        render json: enrollments
      end

    def create
        enrollment = current_user.enrollments.build(course_id: params[:course_id])
        if enrollment.save

         EnrollmentMailer.welcome_email(current_user).deliver_later

          render json: enrollment, status: :created
        else
          render json: enrollment.errors, status: :unprocessable_entity
        end
      end
    end

