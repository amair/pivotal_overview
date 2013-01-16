require 'spec_helper'

describe PrintController do

  it 'should start without a token cookie' do
    request.cookies['token'].should be nil
  end

  it 'should store the token in a cookie when provided' do
    token = 'ABCDEFG123'

    project_resp = load_xml_fixture_file('projects')
    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects").to_return(:status => 200, :body => project_resp, :headers => {})
    get :index, {:token => token}
    response.cookies['token'].should eq(token)
  end

  it 'should override the stored token in the cookie when a new one is supplied' do
    original_token = 'ABC123'
    new_token = 'DEF456'

    request.cookies['token'] = original_token

    project_resp = load_xml_fixture_file('projects')
    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects").to_return(:status => 200, :body => project_resp, :headers => {})
    get :index, {:token => new_token}

    response.cookies['token'].should eq(new_token)

  end

  it 'should retrieve all the projects' do
    double
  end
end

