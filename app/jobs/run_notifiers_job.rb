class RunNotifiersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Notifier.all.each do |notifier|
      NotifyToSlackJob.perform_later(notifier.id)
    end
  end
end
