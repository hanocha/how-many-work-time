class NotifyToSlackJob < ApplicationJob
  queue_as :default

  def perform(*args)
    notifiers = Notifier.all

    client = Slack::Web::Client.new(token: Rails.application.secrets.slack_token)

    notifiers.each do |n|
      client.chat_postMessage(channel: "@#{n.slack_user_name}", text: "hello world from job!")
    end
  end
end
