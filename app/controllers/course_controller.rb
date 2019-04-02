class CourseController < ApplicationController
  def index
    @courses = Course.all
  end
end
