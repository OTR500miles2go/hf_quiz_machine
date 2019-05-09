class CourseController < ApplicationController
  def index
    @courses = Course.where(id: (Question.distinct.pluck(:course_id)))
  end
end
