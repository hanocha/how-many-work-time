require 'rails_helper'

RSpec.describe RunNotifiersJob, type: :job do
  describe '#perform' do
    let!(:notifier_1) { FactoryGirl.create(:notifier, slack_user_name: 'notifier1') }

    subject { RunNotifiersJob.perform_now }

    context '平日の場合' do
      before { travel_to '2017-04-07 00:00:00 JST' }

      it 'NotifyToSlackJob をエンキューする' do
        ActiveJob::Base.queue_adapter = :test
        expect { subject }.to have_enqueued_job(NotifyToSlackJob).with(notifier_1.id)
      end
    end

    context '土日の場合' do
      before { travel_to '2017-04-08 09:00:01 JST' }

      it 'NotifyToSlackJob をエンキューしない' do
        ActiveJob::Base.queue_adapter = :test
        expect { subject }.not_to have_enqueued_job(NotifyToSlackJob)
      end
    end
  end
end
