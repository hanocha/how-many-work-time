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

  def std_work_days
    @main_page.xpath("//*[contains(./text(),'所定労働日数')]/following-sibling::*").text.strip.slice(0,2).to_i
  end

  def std_work_hours
    std_work_days * 8
  end

  def worked_days
    @main_page.xpath("//*[contains(./text(),'実働日数')]/following-sibling::*").text.strip.to_i
  end

  def worked_hours
    worked_times = @main_page.xpath("//*[contains(./text(),'実労働時間')]/following-sibling::*").text.strip
    hours, minutes = worked_times.split(':')
    hours.to_f + (minutes.to_f / 60)
  end

  def salaried_days
    @main_page.xpath("//*[contains(./text(),'有休(全休)')]/following-sibling::*").text.strip.to_i
  end

  def half_salaried_days
    am = @main_page.xpath("//*[contains(./text(),'有休(AM休)')]/following-sibling::*").text.strip.to_f
    pm = @main_page.xpath("//*[contains(./text(),'有休(PM休)')]/following-sibling::*").text.strip.to_f
    (am + pm) * 2
  end
end
