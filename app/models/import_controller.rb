class ImportController
  attr_accessor :stories, :custom_sources

  def initialize()
    @stories = {}
    @custom_sources = YAML.load_file("./config/sources.yml")
  end

  def pull_stories
    self.custom_sources = YAML.load_file("./config/sources.yml")
    pull_reddit
    custom_sources["Reddit"].each{|subreddit| pull_reddit(subreddit)}
    pull_stack_overflow
    custom_sources["Stack Overflow"].each{|stack_tag| pull_stack_overflow(stack_tag)}
    pull_hacker_news
    pull_product_hunt
    custom_sources["Product Hunt"].each{|hunt_page| pull_product_hunt(hunt_page)}
  end

  def add_source(site, subselection)
   data = YAML.load_file("./config/sources.yml")
   data[site] << subselection
   File.open("./config/sources.yml", 'w') { |f| YAML.dump(data, f) }
 end

 def clear_source(site)     #skip edit
   data = YAML.load_file("./config/sources.yml")
   data[site] = []
   File.open("./config/sources.yml", 'w') { |f| YAML.dump(data, f) }
   clear_stories
 end

  private
  def pull_reddit(subreddit=nil)
    #create and pull reddit
    if subreddit
      key = "Reddit - #{subreddit}:"
      stories[key] = RedditJson.new(subreddit).top_story
    else
      stories["Reddit"] = RedditJson.new.top_story
    end
  end

  def pull_stack_overflow(tag = "ruby")
    if tag != "ruby"
      key = "Stack Overflow - #{tag}:"
      stories[key] = StackOverflowImporter.new(tag).top_post
    else
      stories["Stack Overflow"] = StackOverflowImporter.new.top_post
    end
  end

  def pull_hacker_news
    stories["Hacker News"] = HackerNews.new.top_post
  end

  def pull_product_hunt(hunt_page = "tech")
    if hunt_page != "tech"
      key = "Product Hunt - #{hunt_page}:"
      stories[key] = ProductHuntScraper.new(hunt_page).top_post
    else
      stories["Product Hunt"] = ProductHuntScraper.new.top_post
    end
  end

  def clear_stories
    stories.clear
  end


end
