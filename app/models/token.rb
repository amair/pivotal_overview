class Token

  def self.get_token
    PivotalTracker::Client.token = @token
    token_defined?
  end

  def self.update_token( new_token)
    @token = new_token
  end

  private

  def self.token_defined?
    @token.nil? == false
  end
end
