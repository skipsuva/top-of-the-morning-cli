class ImportIO
  attr_accessor :importer


  def open
    puts "Top of the morning to you, sir!"
    puts "Loading your top stories...one moment please..."
  end

  def todays_stories
    self.importer = ImportController.new
    importer.pull_stories
  end

  def list_stories
    counter = 1
    story_array = importer.stories.map do |key, value|
      puts "#{counter}. #{key} --> #{value.title}, #{value.points}."
      counter += 1
      value
    end
    story_array
    # binding.pry
  end

  def selection
    x = list_stories
    puts "\n Please enter the number of the story you'd like to read - or 'exit' to quit:"
    loop do
      selection = gets.chomp
      if selection.downcase == "exit"
        exit_program
        break
      elsif (1..(x.length)).include?(selection.to_i)
        system "open #{x[selection.to_i-1].url}"
      else
        puts "Please enter a valid selection:"
      end
    end

  end

  def exit_program
    puts "Bye!"
  end

  # private
  #
  # def open_story
  # end

end
