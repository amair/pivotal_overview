class ProjectData < PivotalTracker::Project

  def self.find_all_projects

      PivotalTracker::Client.token = Token.get_token
      projects = PivotalTracker::Project.all

      projects
  end

  def self.find_all_stories(project, states=["unscheduled", "unstarted", "started", "finished", "delivered", "accepted", "rejected"])
    PivotalTracker::Client.token = Token.get_token
    stories = project.stories.all(:current_state => states )

    stories
  end

end
