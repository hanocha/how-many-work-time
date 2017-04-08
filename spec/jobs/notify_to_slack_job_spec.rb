require 'rails_helper'

RSpec.describe NotifyToSlackJob, type: :job do
  describe '#perform' do
    let!(:notifier) { FactoryGirl.create(:notifier, slack_user_name: 'saiki') }

    let!(:slack_postMessage_stub) do
      stub_request(:post, 'https://slack.com/api/chat.postMessage').
        with(
          body: hash_including(
            channel: '@saiki',
            token: Rails.application.secrets.slack_token,
          )
        ).and_return(
          body: {
            ok: true,
            ts: '0',
            channel: '12345678',
            message: {},
          }.to_json
        )
    end

    let!(:get_top_page_stub) do
      stub_request(:get, Rails.application.secrets.base_url).with(query: { code: notifier.user.code })
    end

    let!(:get_attendance_page_stub) do
      stub_request(:get, "#{Rails.application.secrets.base_url}/attendance")
    end

    before do
      allow_any_instance_of(WorkTimeInfo).
        to receive(:std_work_days).
        and_return(20)
      
      allow_any_instance_of(WorkTimeInfo).
        to receive(:worked_days).
        and_return(15)
      
      allow_any_instance_of(WorkTimeInfo).
        to receive(:worked_hours).
        and_return(120.0)

      allow_any_instance_of(WorkTimeInfo).
        to receive(:salaried_days).
        and_return(1)

      allow_any_instance_of(WorkTimeInfo).
        to receive(:half_salaried_days).
        and_return(1.5)
    end

    subject { NotifyToSlackJob.perform_now(notifier.id) }

    it '指定されたNotifier ID のユーザに Slack の IM を送る' do
      subject
      expect(slack_postMessage_stub).to have_been_requested
    end
  end
end
