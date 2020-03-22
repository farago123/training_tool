class ChangeTimeToBeStringInCourses < ActiveRecord::Migration[6.0]
  def change
  	  change_column :courses, :time, :string
  end
end
