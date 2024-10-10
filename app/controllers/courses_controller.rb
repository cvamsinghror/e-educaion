class CoursesController < ApplicationController
    def index
        courses = Course.all
        render json: courses
      end
    
      def create
        course = current_user.taught_courses.build(course_params)
        if course.save
          
          render json: course, status: :created
        else
          render json: course.errors, status: :unprocessable_entity
        end
      end
    
      private
    
      def course_params
        params.require(:course).permit(:name, :course_category_id)
      end
    end

