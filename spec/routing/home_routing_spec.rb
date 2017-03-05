require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe 'GET /' do
    it do
      expect(get: '/').to route_to(controller: "home", action: "index")
    end
  end
end
