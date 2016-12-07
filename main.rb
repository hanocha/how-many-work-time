require 'open-uri'
require 'mechanize'
require 'nokogiri'

class Jobcan
  JOBCAN_BASE_URI = "https://ssl.jobcan.jp/employee/attendance?code="
  attr_accessor :code, :agent, :page, :parsed_page

  def initialize(code)
    @code = code
    @agent = Mechanize.new
    @agent.user_agent = 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)'
  end

  def get_page
    top_page = @agent.get(JOBCAN_BASE_URI + @code)
    @page = top_page.link_with(uri: top_page.links[4].uri).click
  end

  def parce_page
    @parce_page = Nokogiri::HTML(@page.body)
  end

  def std_work_days
    @parce_page.xpath("//*[contains(./text(),'所定労働日数')]/following-sibling::*").text.strip.slice(0,2).to_i
  end

  def std_work_hours
    std_work_days * 8
  end

  def worked_days
    @parce_page.xpath("//*[contains(./text(),'実働日数')]/following-sibling::*").text.strip.to_i
  end

  def worked_hours
    @parce_page.xpath("//*[contains(./text(),'実労働時間')]/following-sibling::*").text.strip
  end

  def salaried_days
    @parce_page.xpath("//*[contains(./text(),'有休(全休)')]/following-sibling::*").text.strip.to_i
  end

  def half_salaried_days
    am = @parce_page.xpath("//*[contains(./text(),'有休(AM休)')]/following-sibling::*").text.strip.to_f
    pm = @parce_page.xpath("//*[contains(./text(),'有休(PM休)')]/following-sibling::*").text.strip.to_f
    am + pm
  end
end

