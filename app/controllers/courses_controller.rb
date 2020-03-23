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
	      redirect_to courses_url(@course), :flash => { :notice => "You have successfully created a new course." }
	   else
	      render 'new'
	   end
   
  end

  def show
  	  @course = Course.find(params[:format])
  end

  def signup
      @user = User.find(current_user.id)
      @course = Course.find(params[:course_id])

      if(!@course.users.include?(@user))
        @course.users.push(@user)

        if @course.save
          redirect_to courses_url(@course), :flash => { :notice => "You have successfully signed up for this course." }
        else
          redirect_to courses_url(@course), :flash => { :alert => "There was an error when trying to signup for this course." }
        end 
      else
        redirect_to courses_url(@course), :flash => { :alert => "You are already signed up for this course." }
      end     
  end

  def mycourses
      @courses = current_user.courses
  end

  private

	def course_params
	   params.require(:course).permit(:name, :description, :start_date, :end_date, :time)
	end
end
