class StoriesController < ApplicationController

  def index
    get_pivotal_token
    project = ProjectData.find_project(Integer(params[:project_id]))
    @stories = ProjectData.find_all_stories(project)
  end

  def show
    get_pivotal_token
    project = ProjectData.find_project(Integer(params[:project_id]))
    @story = ProjectData.find_story(project, Integer(params[:id]))

  end
end
