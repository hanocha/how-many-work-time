class RunNotifiersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    return if Time.now.wday == 6 || Time.now.wday == 0

    Notifier.all.each do |notifier|
      NotifyToSlackJob.perform_later(notifier.id)
    end
  end
end
