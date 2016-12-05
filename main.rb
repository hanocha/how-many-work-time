require 'open-uri'
require 'mechanize'
require 'nokogiri'

unless File.exist?('./code.conf')
  print 'please input your code : '
  code = gets.chomp
  exit if code.empty?
  File.open('./code.conf', 'w') do |f|
    f.puts(code)
  end
else
  code = File.open('./code.conf').gets.chomp
end

uri = "https://ssl.jobcan.jp/employee/attendance?code=#{code}"

agent = Mechanize.new
agent.user_agent = 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)'
top_page = agent.get(uri)
main_page = top_page.link_with(uri: top_page.links[4].uri).click

doc = Nokogiri::HTML(main_page.body)
work_days = doc.xpath("//body").css('div.infotpl > table.left > tbody > tr > td')[3].text.strip.slice(0,2)
work_hours = 8 * work_days.to_i

p work_hours
