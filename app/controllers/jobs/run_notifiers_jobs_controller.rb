class Jobs::RunNotifiersJobsController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with(
    name: Rails.application.secrets.basic_auth_username,
    password: Rails.application.secrets.basic_auth_password,
  )

  def create
    RunNotifiersJob.perform_later
    head :created
  end
end
