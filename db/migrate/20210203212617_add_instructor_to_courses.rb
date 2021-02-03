class AddInstructorToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :instructor, :string
  end
end
