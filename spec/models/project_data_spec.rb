require 'spec_helper'

describe ProjectData do

  it 'should ensure the helper functions are being loaded' do
    help.should be(:available)
  end

  it 'should retrieve all the project data' do
    @project_resp = load_xml_fixture_file('projects')

    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects")
    .to_return(:status => 200, :body => @project_resp, :headers => {})

    projects = ProjectData.find_all_projects

    projects.length.should eq(7)

    projects.first.name.should eq('CPP Insurance')

  end

end