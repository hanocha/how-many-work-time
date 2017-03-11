require 'rails_helper'

RSpec.describe Devise::RouteSet, type: :routing do
  describe 'routes to sign_up' do
    it 'GET /users/sign_up' do
      expect(get: '/users/sign_up').
        to route_to('devise/registrations#new')
    end

    it 'GET new_user_registration_path' do
      expect(get: new_user_registration_path).
        to route_to('devise/registrations#new')
    end
  end
end