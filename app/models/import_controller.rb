# Controls site-specific data importes
class ImportController
  attr_accessor :stories, :custom_sources

  def initialize()
    @stories = {}
    @custom_sources = YAML.load_file("./config/sources.yml")
  end

# First checks YAML file for any exisiting tags and loads them as custom sources
  def initial_pull
    pull_reddit
    pull_stack_overflow
    pull_hacker_news
    pull_product_hunt
  end

  def custom_pull(site,subselection)
    case site.downcase
    when "reddit"
      pull_reddit(subselection)
    when "stackoverflow"
      pull_stack_overflow(subselection)
    when "product hunt"
      pull_product_hunt(subselection)
    end
  end

  def pull_stories
    initial_pull
    self.custom_sources = YAML.load_file("./config/sources.yml")
    custom_sources["Reddit"].each{|subreddit| custom_pull("Reddit",subreddit)}
    custom_sources["Stack Overflow"].each{|stack_tag| custom_pull("Stack Overflow", stack_tag)}
    custom_sources["Product Hunt"].each{|hunt_page| custom_pull("Product Hunt", hunt_page)}
  end

# Matches the source site and updates & saves the hash key array in the YAML file
  def add_source(site, subselection)
   data = YAML.load_file("./config/sources.yml")
   data[site] << subselection
   File.open("./config/sources.yml", 'w') { |f| YAML.dump(data, f) }
   custom_pull(site,subselection)
 end

# Clears and saves the matched source hash values in the YAML
 def clear_source(site)
   data = YAML.load_file("./config/sources.yml")
   #generates an array of keys from the site that is being deleted
   keys = data[site].map{|subselection| "#{site} - #{subselection}:"}
   data[site] = [] #clear the site map
   File.open("./config/sources.yml", 'w') { |f| YAML.dump(data, f) }
   custom_clear(keys) #clear the stories from the importer
 end

  private
# Creates a new Reddit Story thru the RedditJson class and pulls the data
  def pull_reddit(subreddit=nil)
    if subreddit
      key = "Reddit - #{subreddit}:"
      stories[key] = RedditJson.new(subreddit).top_story
    else
      stories["Reddit"] = RedditJson.new.top_story
    end
  end

# Creates a new Stack Overflow Story thru the StackOverflowImporter class and pulls the data
  def pull_stack_overflow(tag = "ruby")
    if tag != "ruby"
      key = "Stack Overflow - #{tag}:"
      stories[key] = StackOverflowImporter.new(tag).top_post
    else
      stories["Stack Overflow"] = StackOverflowImporter.new.top_post
    end
  end

# Creates a new Hacker News Story thru the HackerNews class and pulls the data
  def pull_hacker_news
    stories["Hacker News"] = HackerNews.new.top_post
  end

# Creates a new Product Hunt Story thru the ProductHuntScraper class and pulls the data
  def pull_product_hunt(hunt_page = "tech")
    if hunt_page != "tech"
      key = "Product Hunt - #{hunt_page}:"
      stories[key] = ProductHuntScraper.new(hunt_page).top_post
    else
      stories["Product Hunt"] = ProductHuntScraper.new.top_post
    end
  end

  #takes in array of keys and removes those keys from the hash of stories
  def custom_clear(keys)
    keys.each do |key|
      stories.delete(key)
    end
  end

end
