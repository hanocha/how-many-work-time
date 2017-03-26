require 'rails_helper'

RSpec.describe NotifyToSlackJob, type: :job do
  describe '#perform' do
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

    let!(:notifier) { FactoryGirl.create(:notifier, slack_user_name: 'saiki') }

    subject { NotifyToSlackJob.perform_now }

    it 'Notifier を登録しているユーザに Slack の IM を送る' do
      subject
      expect(slack_postMessage_stub).to have_been_requested
    end
  end
end
