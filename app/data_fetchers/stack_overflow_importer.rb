# Utilizes a Stack Overflow API gem
class StackOverflowImporter
  attr_accessor :tag

  def initialize(tag='ruby')
    @tag = tag
  end

  def import
    RubyStackoverflow.featured_questions({page: 1, tagged:tag}).data
  end

  def top_post
    raw = self.import
    raw.sort_by!{|story| story.bounty_amount}
    title = raw[-1].title
    bounty = raw[-1].bounty_amount
    url = raw[-1].link
    StackOverflowStory.new(title,url,bounty)
  end
end
