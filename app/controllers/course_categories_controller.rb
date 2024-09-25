class CourseCategoriesController < ApplicationController
    def index
        categories = CourseCategory.all
        render json: categories
    end

    end
