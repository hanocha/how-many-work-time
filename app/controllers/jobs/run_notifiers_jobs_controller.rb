class Jobs::RunNotifiersJobsController < ActionController::API
  def create
    NotifyToSlackJob.perform_later
    head :created
  end
end
