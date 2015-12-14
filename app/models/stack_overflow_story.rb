class StackOverflowStory < Story
  attr_accessor :bounty

  def initialize(title, url, bounty)
    @bounty = bounty
    @title = title
    @url = url
  end
end
