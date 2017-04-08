require 'rails_helper'

RSpec.describe RunNotifiersJob, type: :job do
  describe '#perform' do
    let!(:notifier_1) { FactoryGirl.create(:notifier, slack_user_name: 'notifier1') }

    subject { RunNotifiersJob.perform_now }

    it 'NotifyToSlackJob をエンキューする' do
      ActiveJob::Base.queue_adapter = :test
      expect { subject }.to have_enqueued_job(NotifyToSlackJob).with(notifier_1.id)
    end
  end
end
