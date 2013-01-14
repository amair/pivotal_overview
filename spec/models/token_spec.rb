require 'spec_helper'

describe 'Token'  do
  it 'should retrieve the stored token' do
    myToken="ABC123"
    Token.update_token(myToken)
    Token.get_token.should eq myToken
  end

end