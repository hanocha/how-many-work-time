class WorkTimeInfo
  attr_reader :page

  def self.find(code)
    new(code)
  end

  def initialize(code)
    @page = code
    @agent = Mechanize.new
    @agent.user_agent = 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)'
    top = @agent.get("#{Rails.application.secrets.base_url}?code=#{code}")
    main_page = top.link_with(uri: top.links[4].uri).click
    @page = Nokogiri::HTML(main_page.body)
  end
end
