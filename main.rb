require 'open-uri'
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
doc = Nokogiri::HTML(open(uri))
