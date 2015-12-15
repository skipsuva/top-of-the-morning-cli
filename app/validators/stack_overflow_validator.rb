class StackOverflowValidator
  attr_accessor :tag, :url

  def initialize(tag)
    @tag = tag
    @url = "http://www.stackoverflow.com/tags/#{tag}"
  end

  def scrape
    Nokogiri::HTML(open(url))
  end

  def validate
    if scrape.css(".summarycount").text == "0"
      false
    else
      true
    end
  end

end



#"no questions"
