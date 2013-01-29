module ProjectStubHelper
  def load_project(project_id, stub_file)
    project_fixture = load_xml_fixture_file(stub_file)
    Token.update_token("12345")

    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/#{project_id}").to_return(:status => 200, :body => project_fixture, :headers => {})

    project = ProjectData.find_project(project_id)

    project
  end

  def load_all_projects stub_file
    projects_fixture = load_xml_fixture_file(stub_file)

    Token.update_token("12345")

    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects").to_return(:status => 200, :body => projects_fixture, :headers => {})

    projects = ProjectData.find_all_projects

    projects

  end
end