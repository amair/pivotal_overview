module TaskStubHelper
  def stub_task(project_id, story_id, task_stub_file)
    task_fixture = load_xml_fixture_file(task_stub_file)
    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/#{project_id}/stories/#{story_id}/tasks").to_return(:status => 200, :body => task_fixture, :headers => {})

    #No return because tasks are wrapped inside the story object, just stubbing the ActiveResource call
    nil
  end
end