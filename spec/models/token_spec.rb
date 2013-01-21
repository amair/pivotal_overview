require 'spec_helper'

describe 'Token'  do
  it 'should start without a token defined' do
    Token.get_token.should eq(false)
  end

  it 'should retrieve the stored token' do
    myToken="ABC123"
    Token.update_token(myToken)
    Token.get_token.should eq(true)
  end

end