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

  def edit
      @course = Course.find(params[:id])
  end

  def update
      @course = Course.find(params[:id])

      start_date_hash = params[:start_date]
      start_year = start_date_hash["Start Date(1i)"].to_i
      start_month = start_date_hash["Start Date(2i)"].to_i
      start_day = start_date_hash["Start Date(3i)"].to_i 
      start_date = Date.new(start_year, start_month, start_day)

      end_date_hash = params[:end_date]
      end_year = end_date_hash["End Date(1i)"].to_i
      end_month = end_date_hash["End Date(2i)"].to_i
      end_day = end_date_hash["End Date(3i)"].to_i 
      end_date = Date.new(end_year, end_month, end_day)


      if @course.update({name: params[:name], description: params[:desc], start_date: start_date, end_date: end_date, time: params[:time]})
        redirect_to courses_url(@course)
      else
        redirect_to courses_url(@course), :flash => { :alert => "There was an error while trying to update this course." }
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

  def delete_all
     
      if Course.delete_all
        redirect_to root_path, :flash => { :notice => "You have successfully deleted all courses." }
      else
        redirect_to root_path, :flash => { :alert => "There was an error when trying to delete all the courses." }
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
