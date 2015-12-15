class StackOverflowValidator
  attr_accessor :tag, :url

  def initialize(tag)
    @tag = tag
    @url = "http://www.stackoverflow.com/tags/#{tag}"
  end

  def scrape
    Nokogiri::HTML(open(url))
  end

# Navigates to tagged question url and scrapes to checks if any questions exisits
  def validate
    if scrape.css(".summarycount").text == "0"
      false
    else
      true
    end
  end

end
