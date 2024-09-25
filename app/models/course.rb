class Course < ApplicationRecord
  belongs_to :course_category
  belongs_to :teacher, class_name: 'User'
end
