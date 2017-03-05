require 'rails_helper'

RSpec.describe WorkTimeInfosController, type: :routing do
  describe 'GET /work_time_info' do
    it do
      expect(get: '/work_time_info?code=123456').
        to route_to(
          controller: 'work_time_infos',
          action: 'show',
          code: '123456',
        )
    end
  end
end
