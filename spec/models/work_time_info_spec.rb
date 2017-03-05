require 'rails_helper'

RSpec.describe WorkTimeInfo, type: :model do
  describe '.find' do
    let(:code) { 'sample_of_code' }

    context '勤怠情報の取得に成功した場合' do
      it '自身のインスタンスを返す' do
        expect(WorkTimeInfo.find(code)).to be_instance_of(WorkTimeInfo)
      end

      it '勤怠情報ページの情報を保存したインスタンスを返す' do
        work_time_info = WorkTimeInfo.find(code)
        expect(work_time_info.page).to be_instance_of(Nokogiri::HTML::Document)
      end
    end

    context '勤怠情報の取得に失敗した場合' do
    end
  end
end
