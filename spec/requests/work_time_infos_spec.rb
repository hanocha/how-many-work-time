require 'rails_helper'

RSpec.describe 'WorkTimeInfos', type: :request do
  describe '#show' do
    it 'ステータスコード200を返す' do
      get work_time_info_path
      expect(response).to have_http_status(:ok)
    end
  end
end
