class ImportController
  attr_accessor :stories

  def initialize()
    @stories = {}
  end

  def pull_stories
    pull_reddit
    pull_stack_overflow
    pull_hacker_news
    pull_product_hunt
  end


  private
  def pull_reddit
    #create and pull reddit
    stories["Reddit"] = RedditJson.new.top_story
  end

  def pull_stack_overflow
    stories["Stack Overflow"] = StackOverflowImporter.new.top_post
  end

  def pull_hacker_news
    stories["Hacker News"] = HackerNews.new.top_post
  end

  def pull_product_hunt
    stories["Product Hunt"] = ProductHuntScraper.new.top_post
  end
end
