require 'rails_helper'

RSpec.describe WorkTimeInfo, type: :model do
  describe '.find' do
    it '自身のインスタンスを返す' do
      expect(WorkTimeInfo.find).to be_instance_of(WorkTimeInfo)
    end
  end
end
