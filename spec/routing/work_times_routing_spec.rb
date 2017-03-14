require 'rails_helper'

RSpec.describe WorkTimesController, type: :routing do
  describe 'GET /work_time' do
    it do
      expect(get: '/work_time').
        to route_to(controller: 'work_times', action: 'show')
    end
  end
end
