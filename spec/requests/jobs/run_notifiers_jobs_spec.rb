require 'rails_helper'

RSpec.describe 'Jobs::RunNotifiersJobs', type: :request do
  describe '#create' do
    context 'POST /jobs/run_notifiers' do
      subject { post '/jobs/run_notifiers' }

      it 'NotifyToSlackJob をエンキューする' do
        ActiveJob::Base.queue_adapter = :test
        expect { subject }.to have_enqueued_job(NotifyToSlackJob)
      end

      it 'ステータスコード 201 Created を返す' do
        subject
        expect(response).to have_http_status(:created)
      end
    end
  end
end
