require 'rails_helper'

RSpec.describe 'Jobs::RunNotifiersJobs', type: :request do
  describe '#create' do
    subject { post '/jobs/run_notifiers' }
    it 'POST /jobs/run_notifiers' do
      ActiveJob::Base.queue_adapter = :test
      expect { subject }.to have_enqueued_job(NotifyToSlackJob)
    end
  end
end
