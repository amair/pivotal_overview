require 'spec_helper'

describe ProjectData do

  it 'should ensure the helper functions are being loaded' do
    help.should be(:available)
  end

  before(:each) do
    project_resp = load_xml_fixture_file('projects')

    Token.update_token("12345")

    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects").to_return(:status => 200, :body => project_resp, :headers => {})

    @projects = ProjectData.find_all_projects
  end


  it 'should retrieve all the project data' do

    @projects.length.should eq(7)

    @projects.first.name.should eq('CPP Insurance')

  end

  it 'should retrieve all active stories for a project' do
    stories_resp = load_xml_fixture_file('active_stories')

    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/332489/stories?filter=current_state:unscheduled,unstarted,started,finished,delivered,accepted,rejected%20story_type:feature,bug,chore").to_return(:status => 200, :body => stories_resp, :headers => {})

    project = @projects.first

    stories = ProjectData.find_all_stories(project)

    stories.length.should eq(36)
  end

  it 'should retrieve only stories in the requested state' do
    stories_resp = load_xml_fixture_file('filtered_stories')

    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/332489/stories?filter=current_state:unscheduled,unstarted%20story_type:feature,bug,chore").to_return(:status => 200, :body => stories_resp, :headers => {})

    project = @projects.first

    filter=["unscheduled","unstarted"]

    stories = ProjectData.find_all_stories(project, filter)

    stories.length.should eq(26)
  end

  it 'should retrieve an individual story' do
    story_bug = load_xml_fixture_file('story_bug')
    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/332489/stories/25400385").to_return(:status => 200, :body => story_bug, :headers => {})

    project = @projects.first

    story = ProjectData.find_story(project, Integer(25400385))
    story.id.should eq(25400385)
  end


end