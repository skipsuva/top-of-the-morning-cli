class RedditJson
  attr_accessor :subreddit

  def initialize(subreddit = nil)
    @subreddit = subreddit
  end

  def pull_json
    subreddit ? url = "http://reddit.com/r/#{subreddit}/.json" : url = "http://reddit.com/.json"
    JSON.parse(RestClient.get(url))
  end

  def top_story
    raw = pull_json
    i = 0
    while raw["data"]["children"][i]["data"]["stickied"]
      i += 1
    end
    top_post = raw["data"]["children"][i]
    title = top_post["data"]["title"]
    url = top_post["data"]["url"]
    points = top_post["data"]["score"]

    RedditStory.new(title, url, points)
  end

end
