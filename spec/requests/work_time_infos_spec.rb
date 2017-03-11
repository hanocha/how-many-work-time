require 'rails_helper'

RSpec.describe 'WorkTimeInfos', type: :request do
  let(:code) { 'test_code' }

  let!(:get_top_page_stub) do
    stub_request(:get, Rails.application.secrets.base_url).
      with(query: { code: code })
  end

  let!(:get_attendance_page_stub) do
    stub_request(:get, "#{Rails.application.secrets.base_url}/attendance")
  end

  before do
    allow_any_instance_of(WorkTimeInfo).
      to receive(:std_work_hours).
      and_return(168)
    
    allow_any_instance_of(WorkTimeInfo).
      to receive(:worked_hours).
      and_return(152)
    
    allow_any_instance_of(WorkTimeInfo).
      to receive(:remain_work_days).
      and_return(5)

    allow_any_instance_of(WorkTimeInfo).
      to receive(:work_time_margin).
      and_return(1)

    allow_any_instance_of(WorkTimeInfo).
      to receive(:required_work_times).
      and_return(8)
  end

  subject { get work_time_info_path(code: 'test_code') }

  describe '#show' do
    it 'ステータスコード200を返す' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it '勤務表ページを取得する' do
      subject
      expect(get_attendance_page_stub).to have_been_requested
    end
  end
end
