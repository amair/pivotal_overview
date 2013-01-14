class Token
  def self.get_token
    #logger.debug "#{params}"
    if @token.nil?
      if params[:token]
        @token = params[:token]
        cookies.permanent[:token] = @token unless @token.nil?
        #logger.debug "Retrieve Pivotal token #{@token} from page submission and store in cookie"
      else
        if cookies[:token].nil?
          logger.fatal "Cannot figure out tracker token - giving up"
        else
          @token = cookies[:token]
          #logger.debug "Retrieving token #{@token} from cookie"
        end
      end
    end
    @token
  end

  def self.update_token( new_token)
    @token = new_token
  end
end
