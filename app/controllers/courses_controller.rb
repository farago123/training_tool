class CoursesController < ApplicationController
  
  def index
    if params[:search]
      @courses = Course.where('name LIKE ?', "%#{params[:search]}%")
      @courses |= Course.where('description LIKE ?', "%#{params[:search]}%")
      @courses |= Course.where('start_date LIKE ?', "%#{params[:search]}%")
      @courses |= Course.where('end_date LIKE ?', "%#{params[:search]}%")
      @search = true 
    else
      @courses = Course.all
      @search = false
    end
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

  def destroy

      @course = Course.find(params[:id])
      
      if Course.destroy(params[:id])
        redirect_to root_path, :flash => { :notice => "You have successfully deleted this course." }
      else
        redirect_to courses_url(@course), :flash => { :alert => "There was an error when trying to delete course." }
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
      if params[:search]
        @courses = current_user.courses.where("name LIKE ? AND end_date > #{Date.today}", "%#{params[:search]}%")
        @courses |= current_user.courses.where("description LIKE ? AND end_date > #{Date.today}", "%#{params[:search]}%")
        @courses |= current_user.courses.where('start_date LIKE ?', "%#{params[:search]}%")
        @courses |= current_user.courses.where('end_date LIKE ?', "%#{params[:search]}%")
        @search = true 
      else
        @courses = current_user.courses
        @search = false
      end
  end

  private

	def course_params
	   params.require(:course).permit(:name, :description, :start_date, :end_date, :time, :search)
	end
end
