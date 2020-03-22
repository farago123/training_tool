class CoursesController < ApplicationController
  def index
  	  @courses = Course.all
  end

  def new
  	  @course = Course.new
  end

  def create
       @course = Course.new(course_params)
	
	   if @course.save
	      redirect_to courses_url(@course)
	   else
	      render 'new'
	   end
   
  end

  def show
  	  @course = Course.find(params[:format])
  end

  private

	def course_params
	   params.require(:course).permit(:name, :description, :start_date, :end_date, :time)
	end
end
