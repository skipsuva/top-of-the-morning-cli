class StackOverflowStory < Story
  attr_accessor :points

  def initialize(title, url, points)
    @points = points
    @title = title
    @url = url
  end
end
