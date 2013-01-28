require 'spec_helper'

describe 'Token'  do

  before(:each) { Token.instance_variable_set :@token, nil }

  it 'should start without a token defined' do
    Token.set?.should eq(false)
  end

  it 'should retrieve the stored token' do
    myToken="ABC123"
    Token.update_token(myToken)
    Token.set?.should eq(true)
  end

end