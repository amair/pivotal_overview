require 'spec_helper'

describe PivotalTracker::Story do

  before :each do
    project_data = load_xml_fixture_file('project_332489')
    Token.update_token("12345")

    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/332489").to_return(:status => 200, :body => project_data, :headers => {})

    @project = ProjectData.find_project(332489)

  end

  it 'should return nil for points on a bug' do
    #@story.points should eq(nil)
  end

end
