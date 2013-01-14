class Token
  def self.get_token
    @token
  end

  def self.update_token( new_token)
    @token = new_token
  end
end
