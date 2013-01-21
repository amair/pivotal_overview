class Token
  @token=nil   #N.B. Class Instance Variable

  def self.get_token
    PivotalTracker::Client.token = @token
    @token.present?
  end

  def self.update_token( new_token)
    @token = new_token
  end

end
