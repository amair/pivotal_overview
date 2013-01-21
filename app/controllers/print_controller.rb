require 'story_extensions'
require 'pdf_library'

class PrintController < ApplicationController

  @current_filter = @state_selection

  def index
    @state_selection = ["unscheduled", "unstarted", "started", "finished", "delivered", "accepted", "rejected"]

    get_pivotal_token

    @projects = ProjectData.find_all_projects
  end

  def create
    print_stories = params[:story]
    @stories=[]

    get_pivotal_token

    # Extract the project id and story id from the concatenated params has we created
    print_stories.each do |s|
      str = s.split
      project = ProjectData.find_project Integer(str[0])
      @stories.push ProjectData.find_story(project,Integer(str[1]))
    end

    pdf = PDF::Generator.new(@stories)
    file = pdf.write_to

    send_file file.path, :type=>"application/pdf" unless file.nil?

    #file.unlink  # deletes the temp file
  end

end
