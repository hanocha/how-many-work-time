require 'open-uri'
require 'mechanize'
require 'nokogiri'

class Jobcan
  JOBCAN_BASE_URI = "https://ssl.jobcan.jp/employee/attendance?code="
  attr_accessor :code, :agent, :main_page

  def initialize(code)
    @code = code
    @agent = Mechanize.new
    @agent.user_agent = 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)'
    top = @agent.get(JOBCAN_BASE_URI + @code)
    main = top.link_with(uri: top.links[4].uri).click
    @main_page = Nokogiri::HTML(main.body)
  end

  # 所定労働日数
  def std_work_days
    @main_page.xpath("//*[contains(./text(),'所定労働日数')]/following-sibling::*").text.strip.slice(0,2).to_i
  end

  # 所定労働時間
  def std_work_hours
    std_work_days * 8
  end

  # 実働日数
  def worked_days
    @main_page.xpath("//*[contains(./text(),'実働日数')]/following-sibling::*").text.strip.to_i
  end

  # 実労働時間
  # 単位[hour]で表された浮動小数点で表したもの
  def worked_hours
    worked_times = @main_page.xpath("//*[contains(./text(),'実労働時間')]/following-sibling::*").text.strip
    hours, minutes = worked_times.split(':')
    hours.to_f + (minutes.to_f / 60)
  end

  # 有給消化数
  def salaried_days
    @main_page.xpath("//*[contains(./text(),'有休(全休)')]/following-sibling::*").text.strip.to_i
  end

  # 半休消化数
  # 半休1回が0.5として表示されるので、半休消化数は * 2したものになる
  # 午前と午後は一緒くたにした
  def half_salaried_days
    am = @main_page.xpath("//*[contains(./text(),'有休(AM休)')]/following-sibling::*").text.strip.to_f
    pm = @main_page.xpath("//*[contains(./text(),'有休(PM休)')]/following-sibling::*").text.strip.to_f
    (am + pm) * 2
  end

  # 今月の残り出勤可能日数
  def remain_work_days
    std_work_days - (worked_days + salaried_days)
  end

  # 実質労働時間
  # 実労働時間 + 有給分の労働時間
  def excess_work_times
    worked_hours + (salaried_days * 8) + (half_salaried_days * 4)
  end

  # 何時間余裕があるか(残り全ての日８時間労働すると仮定して)
  def work_time_margin
    excess_work_times - (std_work_hours - (remain_work_days * 8))
  end

  # 何時間働けばいいか
  def required_work_times
    (std_work_hours - excess_work_times) / remain_work_days
  end

  def self.to_time(float_time)
    "#{float_time.floor} 時間 #{((float_time % 1) * 60).floor} 分"
  end
end
