class RedditJson
  attr_accessor :subreddit

  def initialize(subreddit = nil)
    @subreddit = subreddit
  end

  def pull_json
    subreddit ? url = "http://reddit.com/r/#{subreddit}/.json" : "http://reddit.com/.json"
    JSON.parse(RestClient.get(url))
  end

  def top_story
    raw = pull_json
    top_post = raw["data"]["children"].first

    title = top_post["data"]["title"]
    url = top_post["data"]["url"]
    points = top_post["data"]["score"]

    RedditStory.new(title, url, points)
  end

end
