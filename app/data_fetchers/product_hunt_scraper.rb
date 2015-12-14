class ProductHuntScraper
  attr_reader :url

  def initialize
    @url = "https://www.producthunt.com/tech"
  end

  def self.product_scraper
    doc = Nokogiri::HTML(open(url))
    top_article = doc.css(".post-item.v-category-tech.v-with-image").first

    title = top_article.css(".post-item--text--name").text
    url = "https://www.producthunt.com#{top_article.css(".post-item--text--name").attribute("href")}"
    points = top_article.css("span.post-vote-button--count").text.to_i

    ProductHuntStory.new(title, url, points)
  end
end
