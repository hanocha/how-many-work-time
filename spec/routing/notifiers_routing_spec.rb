require 'rails_helper'

RSpec.describe NotifiersController, type: :routing do
  describe 'GET /notifier' do
    it do
      expect(get: '/notifier').
        to route_to(controller: 'notifiers', action: 'show')
    end
  end

  describe 'POST /notifier' do
    it do
      expect(post: '/notifier').
        to route_to(controller: 'notifiers', action: 'create')
    end
  end
end
