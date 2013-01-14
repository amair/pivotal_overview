class PrintController < ApplicationController

  def index
    @state_selection = ["unscheduled", "unstarted", "started", "finished", "delivered", "accepted", "rejected"]

    @projects = ProjectData.find_all_projects

  end
end
