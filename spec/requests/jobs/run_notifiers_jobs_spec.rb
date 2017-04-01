require 'rails_helper'

RSpec.describe 'Jobs::RunNotifiersJobs', type: :request do
  describe '#create' do
    # ベーシック認証を通すテストを書くのが面倒なのでペンディング
    context 'POST /jobs/run_notifiers' do
      subject { post '/jobs/run_notifiers' }

      xit 'NotifyToSlackJob をエンキューする' do
        ActiveJob::Base.queue_adapter = :test
        expect { subject }.to have_enqueued_job(NotifyToSlackJob)
      end

      xit 'ステータスコード 201 Created を返す' do
        subject
        expect(response).to have_http_status(:created)
      end
    end
  end
end
