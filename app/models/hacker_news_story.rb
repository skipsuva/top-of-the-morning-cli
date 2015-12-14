require_relative 'story.rb'

class HackerNewsStory < Story
  attr_accessor :points

  def initialize(title, url, points)
    @title = title
    @url = url
    @points = points
  end

end
