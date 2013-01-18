class PrintController < ApplicationController

  @current_filter = @state_selection

  def index
    @state_selection = ["unscheduled", "unstarted", "started", "finished", "delivered", "accepted", "rejected"]

    get_pivotal_token

    @projects = ProjectData.find_all_projects
  end

  def create
    print_stories = params[:story]

    logger.debug("Printing stories #{print_stories}")

    print_stories.each do |s|
      str = s.split
      logger.debug("Project #{s[0]}, Story #{s[1]}")
    end

    @ps=Hash.new
    @stories=[]
  end

  def old_create
     print_stories = params[:story]

     retrieveProjects
     @stories=[]

     @ps=Hash.new

     print_stories.each do |s|
       str = s.split

       @ps[str[0]] = Array.new if !@ps.has_key? str[0]
       @ps[str[0]].push str[1]
     end

     @ps.each do |project_id, story_ids|
       story_ids.each do |s_id|
         @stories.push get_story(project_id, s_id)
       end
     end

     pdf = Pdf::Generator.new(@stories)
     file = pdf.write_to

     send_file file.path, :type=>"application/pdf" unless file.nil?

     file.unlink  # deletes the temp file

   end

end
