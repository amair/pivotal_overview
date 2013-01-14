class ProjectData < PivotalTracker::Project

  def self.find_all_projects

    begin
      PivotalTracker::Client.token = Token.get_token
      #logger.debug "Using token #{get_token} to get Projects"
      projects = PivotalTracker::Project.all

      #logger.debug "Found #{projects.length} Projects"
      #projects.each_with_index { |p, x| p.div_class = "project#{(x % 5).to_s; p.name = @@projects[x].name}"

      projects
    rescue => e
      #logger.debug e.class
      #logger.error e.message
    end

  end
end
