class HackerNews
  include RubyHackernews

  def initialize

  end

  def importer
    Entry.all.first
  end

  def parser
    top_post = importer
    title = top_post.link.title
    url = top_post.link.href
    points = top_post.voting.score

    HackerNewsStory.new(title, url, points)
  end

end
