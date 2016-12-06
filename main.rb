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
    top_page = @agent.get(JOBCAN_BASE_URI.join(@code))
    @page = top_page.link_with(uri: top_page.links[4].uri).click
  end

  def parce_page
    @parce_page = Nokogiri::HTML(main_page.body)
  end

  def work_days
    @parce_page.xpath("//*[contains(./text(),'所定労働日数')]/following-sibling::*")
  end
end

