class RunNotifiersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    NotifyToSlackJob.perform_later
  end
end
