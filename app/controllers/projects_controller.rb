class ProjectsController < ApplicationController

  def index
    get_pivotal_token
    @projects = ProjectData.find_all_projects
  end

  def show
    get_pivotal_token
    @project = ProjectData.find_project(Integer(params[:id]))
    logger.debug("Project #{params[:id]}")
  end
end
