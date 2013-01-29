require 'spec_helper'

describe ProjectData do

  it 'should ensure the helper functions are being loaded' do
    help.should be(:available)
  end

  before(:each) do
    @projects = load_all_projects 'projects'
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
    story_id=25400385
    project = @projects.first

    story= load_story(project,story_id,'story_bug')

    story.id.should eq(story_id)
  end


end