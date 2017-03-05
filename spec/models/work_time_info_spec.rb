require 'rails_helper'

RSpec.describe WorkTimeInfo, type: :model do
  describe '.find' do
    let(:code) { 'sample_of_code' }

    let!(:get_top_page_stub) do
      stub_request(:get, "#{Rails.application.secrets.base_url}?code=#{code}").
        with(query: { code: code }).
        to_return(
          status: 200,
          body: %|<a href="#">a</a>
<a href="#">b</a>
<a href="#">c</a>
<a href="#">d</a>
<a href="/employee/attendance">e</a>
          %|,
          headers: { content_type: 'text/html' }
        )
    end

    let!(:get_work_time_info_page_stub) do
      stub_request(:get, "#{Rails.application.secrets.base_url}/attendance").
        to_return(
          status: 200,
          body: 'test',
          headers: { content_type: 'text/html' }
        )
    end

    subject { WorkTimeInfo.find(code) }

    context '勤怠情報の取得に成功したとき' do
      it 'トップページを取得する' do
        subject
        expect(get_top_page_stub).to have_been_requested
      end

      it '出勤簿を取得する' do
        subject
        expect(get_work_time_info_page_stub).to have_been_requested
      end

      it '自身のインスタンスを返す' do
        expect(WorkTimeInfo.find(code)).to be_instance_of(WorkTimeInfo)
      end

      it '勤怠情報ページの情報を保存したインスタンスを返す' do
        work_time_info = WorkTimeInfo.find(code)
        expect(work_time_info.page).to be_instance_of(Nokogiri::HTML::Document)
      end
    end

    xcontext '勤怠情報の取得に失敗した場合' do
    end
  end
end
