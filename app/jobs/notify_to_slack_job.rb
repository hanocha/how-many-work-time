class NotifyToSlackJob < ApplicationJob
  queue_as :default

  def perform(*args)
    notifiers = Notifier.all

    client = Slack::Web::Client.new(token: Rails.application.secrets.slack_token)

    notifiers.each do |n|
      work_time_info = WorkTimeInfo.find(n.user.code) 
      return if work_time_info.std_work_days == 0

      text = <<-EOS
:clock10: #{Time.now.strftime('%Y年%m月%d日')} の勤怠情報

所定労働時間
#{WorkTimeInfo.to_time(work_time_info.std_work_hours)}

今までの実質労働時間
#{WorkTimeInfo.to_time(work_time_info.excess_work_times)}

今月の残り出勤日数
#{work_time_info.remain_work_days} 日

貯金
#{WorkTimeInfo.to_time(work_time_info.work_time_margin)}

1日あたり何時間働けばいいか
#{WorkTimeInfo.to_time(work_time_info.required_work_times)}
EOS

      client.chat_postMessage(channel: "@#{n.slack_user_name}", text: text)
    end
  end
end
