class ProjectData < PivotalTracker::Project

  def self.find_all_projects

    if Token.get_token then
      projects = PivotalTracker::Project.all
    end

    projects
  end

  def self.find_project (id)
    if Token.get_token then
      project = PivotalTracker::Project.find(id)
    end

    project
  end

  def self.find_all_stories(project, states=["unscheduled", "unstarted", "started", "finished", "delivered", "accepted", "rejected"])
    if Token.get_token then
      stories = project.stories.all(:current_state => states, :story_type => ['feature', 'bug', 'chore'] )
    end

    stories
  end

  def self.find_story(project, id)
    if Token.get_token then
      story = project.stories.find(id)
    end

    story
  end

  def self.find_tasks(story)
    if Token.get_token then
      tasks = story.tasks.all
    end

    tasks
  end

  def self.find_notes(story)
    if Token.get_token then
      notes = story.notes.all
    end

    notes
  end


end
