class Jobs::RunNotifiersJobsController < ApplicationController
  def create
    NotifyToSlackJob.perform_later
  end
end
