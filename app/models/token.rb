class Token
  @token=nil   #N.B. Class Instance Variable

  def self.set?
    PivotalTracker::Client.token = @token
    !@token.blank?
  end

  def self.update_token( new_token)
    @token = new_token
  end

end
