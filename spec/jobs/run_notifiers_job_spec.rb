require 'rails_helper'

RSpec.describe RunNotifiersJob, type: :job do
  describe '#perform' do
    subject { RunNotifiersJob.perform_now }

    it 'NotifyToSlackJob をエンキューする' do
      ActiveJob::Base.queue_adapter = :test
      expect { subject }.to have_enqueued_job(NotifyToSlackJob)
    end
  end
end
