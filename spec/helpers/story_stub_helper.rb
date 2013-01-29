module StoryStubHelper
  def load_story(project, story_id, story_stub_file)
    story_fixture = load_xml_fixture_file(story_stub_file)
    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/#{project.id}/stories/#{story_id}").to_return(:status => 200, :body => story_fixture, :headers => {})

    story = ProjectData.find_story(project, story_id)

    story
  end
end