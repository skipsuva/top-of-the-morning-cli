class StackOverflowValidator
  attr_accessor :tag, :url

  def initialize(tag)
    @tag = tag
    @url = "http://www.stackoverflow.com/questions/tagged/#{tag}"
  end

  def scrape
    Nokogiri::HTML(open(url))
  end

  def validate
    binding.pry
    scrape.css("h2").text.include? "There are no questions" ? false : true
  end

end



#"no questions"
