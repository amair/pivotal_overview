class PrintController < ApplicationController

  @current_filter = @state_selection

  def index
    @state_selection = ["unscheduled", "unstarted", "started", "finished", "delivered", "accepted", "rejected"]

    token = params[:token]

    unless token.nil?
      Token.update_token(token)
      cookies.permanent[:token] = token
      logger.debug "Retrieve Pivotal token #{token} from page submission and store in cookie"
    end

    unless cookies[:token].nil?
      Token.update_token(cookies[:token])
      logger.debug ("Using token #{cookies[:token]} from the session cookie")
    end

    @projects = ProjectData.find_all_projects
  end
end
