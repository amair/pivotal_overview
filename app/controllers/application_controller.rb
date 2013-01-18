class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :get_filtered_stories, :get_current_year

  def get_filtered_stories(project)
    filter = params[:state]  || ["unscheduled", "unstarted"]
    ProjectData.find_all_stories(project, filter )
  end

  def get_current_year
    date=Date.today
    date.year
  end

  def get_pivotal_token
    @token = params[:token]

    unless @token.nil?
      Token.update_token(@token)
      cookies.permanent[:token] = @token
      logger.debug "Retrieve Pivotal token #{@token} from page submission and store in cookie"
    end

    unless cookies[:token].nil?
      Token.update_token(cookies[:token])
      logger.debug ("Using token #{cookies[:token]} from the session cookie")
    end
  end

end
