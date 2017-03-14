require 'rails_helper'

RSpec.describe 'WorkTimes', type: :request do
  let(:code) { 'test_code' }

  let!(:get_top_page_stub) do
    stub_request(:get, Rails.application.secrets.base_url).with(query: { code: code })
  end

  let!(:get_attendance_page_stub) do
    stub_request(:get, "#{Rails.application.secrets.base_url}/attendance")
  end

  subject { get work_time_info_path }

  describe '#show' do
    context 'ログイン済みのとき' do
      let!(:user) { FactoryGirl.create(:user, code: code) }
      before { login_as user }

      context '正常なコードの場合' do
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

        it 'ステータスコード200を返す' do
          subject
          expect(response).to have_http_status(:ok)
        end

        it '勤務表ページを取得する' do
          subject
          expect(get_attendance_page_stub).to have_been_requested
        end
      end

      context '不正なコードの場合' do
        it 'コードの編集ページにリダイレクトする' do
          subject
          expect(response).to redirect_to(edit_user_registration_path)
        end
      end
    end

    context '未ログインのとき' do
      it 'ログインページにリダイレクトする' do
        subject
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
