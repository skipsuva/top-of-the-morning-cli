class RedditSearch
  attr_accessor :subreddit

  def initialize(subreddit)
    @subreddit = subreddit
  end

  def validate
    site = JSON.parse(RestClient.get("http://reddit.com/r/#{subreddit}/.json"))
    if site["data"]["children"].empty?
      false
    else
      true
    end
  end
end
