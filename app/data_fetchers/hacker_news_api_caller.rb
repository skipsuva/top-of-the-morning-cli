class HackerNews
  include RubyHackernews

  def initialize

  end

  def importer
    Entry.all.first
  end

  def top_post
    top_story = importer
    title = top_story.link.title
    url = top_story.link.href
    points = top_story.voting.score

    HackerNewsStory.new(title, url, points)
  end

end
