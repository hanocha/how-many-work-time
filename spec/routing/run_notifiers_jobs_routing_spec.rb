require 'rails_helper'

RSpec.describe 'routing to /jobs/run_notifiers', type: :routing do
  it 'post /jobs/run_notifiers' do
    expect(post: '/jobs/run_notifiers').
      to route_to(controller: 'jobs/run_notifiers_jobs', action: 'create')
  end
end