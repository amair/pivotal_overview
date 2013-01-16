class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :get_filtered_stories

  def get_filtered_stories(project)
    filter = params[:state]  || ["unscheduled", "unstarted"]
    ProjectData.find_all_stories(project, filter )
  end

end
