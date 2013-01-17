class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :get_filtered_stories, :get_current_year

  def get_filtered_stories(project)
    filter = params[:state]  || ["unscheduled", "unstarted"]
    ProjectData.find_all_stories(project, filter )
  end

  def get_current_year
    date=Date.today
    date.year
  end

end
