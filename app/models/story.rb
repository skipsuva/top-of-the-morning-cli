class Story
  attr_accessor :title, :url, :points

  def initialize(title, url, points)
    @title = title
    @url = url
    @points = points
  end

  def print_story
    "#{title}, #{points} points."
  end
end
