require 'spec_helper'

describe PivotalTracker::Story do

  before :each do
    @project_id = 332489
    @project = load_project(@project_id, "project_332489")
  end

  it 'should return nil for points on a bug' do
    story = load_story(@project, 25400385, 'story_bug')

    story.points.should be_nil
  end

  it 'should return not yet estimated for points on a feature which has not been estimates' do
    story = load_story(@project, 40181287, 'unestimated_story')
    story.points.should eq("Points: Not yet estimated")
  end

  it 'should return the estimate when it is present' do
    story = load_story(@project, 39945739, 'estimated_story')

    story.points.should eq("Points: 1")
  end

  it 'should return an empty string when there are no tasks' do
    story_id=39945739

    story = load_story(@project, story_id, 'estimated_story')
    stub_task(@project_id,story_id,'no_tasks')

    story.task_list.should eq("")
  end

  it 'should return a concatenated list of all tasks' do
    story_id=27023259

    story = load_story(@project, story_id, 'story_with_tasks_and_attachments')
    stub_task(@project_id,story_id,'tasks')

    story.task_list.should include("*")
  end

  it 'should return an empty string when all tasks are complete' do
    story_id=27023259

    story = load_story(@project, story_id, 'story_with_tasks_and_attachments')
    stub_task(@project_id,story_id,'tasks_complete')

    story.task_list.should include("")
  end

  it 'should return black as the story colour' do
    story = load_story(@project, 25400385, 'story_bug')

    story.colour.should eq("000000")

  end

  it 'should return an empty string when there are no labels' do
    story = load_story(@project, 25400385, 'story_bug')

    story.label_list.should eq("")
  end

  it 'should return the labels when they are present' do
    story = load_story(@project, 27023259, 'story_with_tasks_and_attachments')

    story.label_list.should eq("7th april,cpp4")
  end

end
