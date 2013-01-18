class ProjectData < PivotalTracker::Project

  def self.find_all_projects

      PivotalTracker::Client.token = Token.get_token
      projects = PivotalTracker::Project.all

      projects
  end

  def self.find_project (id)
    PivotalTracker::Client.token = Token.get_token
    project = PivotalTracker::Project.find(id)

    project
  end

  def self.find_all_stories(project, states=["unscheduled", "unstarted", "started", "finished", "delivered", "accepted", "rejected"])
    PivotalTracker::Client.token = Token.get_token
    stories = project.stories.all(:current_state => states, :story_type => ['feature', 'bug', 'chore'] )

    stories
  end

  def self.find_story(project, id)
    PivotalTracker::Client.token = Token.get_token
    story = project.stories.find(id)

    story
  end

  def self.find_tasks(story)
    PivotalTracker::Client.token = Token.get_token
    tasks = story.tasks.all

    tasks
  end

  def self.find_notes(story)
    PivotalTracker::Client.token = Token.get_token
    notes = story.notes.all

    notes
  end


end
