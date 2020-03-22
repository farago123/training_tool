class AddColumnsToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :name, :string
    add_column :courses, :description, :text
    add_column :courses, :start_date, :date
    add_column :courses, :end_date, :date
    add_column :courses, :time, :time
  end
end
