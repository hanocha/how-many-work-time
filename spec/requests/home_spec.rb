require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe '#index' do
    it 'ホーム画面を表示する' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
