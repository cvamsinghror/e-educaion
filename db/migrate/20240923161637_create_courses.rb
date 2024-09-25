class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :course_category, null: false, foreign_key: true
      t.integer :teacher_id

      t.timestamps
    end
  end
end
