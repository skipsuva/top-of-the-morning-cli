class ProductHuntScraper
  attr_reader :url

  def initialize(url = "https://www.producthunt.com/tech")
    @url = url
  end

  def product_scrape
    Nokogiri::HTML(open(url))
  end

  def top_post
    top_article = product_scrape.css(".post-item.v-category-tech.v-with-image").first
    title = top_article.css(".post-item--text--name").text
    url = "https://www.producthunt.com#{top_article.css(".post-item--text--name").attribute("href")}"
    points = top_article.css("span.post-vote-button--count").text.to_i

    ProductHuntStory.new(title, url, points)
  end
end