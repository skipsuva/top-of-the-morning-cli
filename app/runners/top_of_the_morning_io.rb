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
      puts "#{counter}. #{key.capitalize} --> #{value.print_story}"
      counter += 1
      value
    end
    story_array
  end

  def selection
    x = list_stories
    puts "\n Please enter the number of the story you'd like to read
     - type 'add' to add more sources
     - type 'clear' to remove added sources
     - or 'exit' to quit:"
    loop do
      selection = (gets.chomp).downcase
      if selection == "exit" || selection == "quit"
        exit_program
        break
      elsif selection == "add"
        add_sources
        importer.pull_stories
        x = list_stories
      elsif selection == "clear"     #skip edits
        remove_sources
        importer.pull_stories
        x = list_stories

      elsif (1..(x.length)).include?(selection.to_i)
        system "open #{x[selection.to_i-1].url}"
      else
        puts "Please enter a valid selection:"
      end
    end

  end

  def add_sources
    puts "Which source would you like to add from?
    -Reddit
    -Product Hunt
    -Stack Overflow"
    loop do
      selection = (gets.chomp).downcase
      if selection == "reddit"
        break if add_to_reddit
        puts "make another selection, or type 'exit'"
      elsif selection == "product hunt"
        break if add_to_product_hunt
        puts "make another selection, or type 'exit'"
      elsif selection == "stack overflow"
        break if add_to_stack_overflow
        puts "make another selection, or type 'exit'"
      elsif seleciton == 'exit'
        break
      else
        puts "Sorry, I didn't get, please make a valid selection"
      end
    end
  end


  def add_to_reddit
    loop do
      puts "Type in any subreddit, or type 'exit':"
      selection = (gets.chomp).downcase
      if selection == "exit"
        return false
      elsif RedditValidator.new(selection).validate
        importer.add_source("Reddit",selection)
        puts "You added the #{selection.capitalize} subreddit"
        return true
      else
        puts "I'm sorry, that's not a valid subreddit, try again!"
      end
    end
  end

  def add_to_product_hunt
    choices = ["games","books","podcasts"]
    loop do
      puts "Select one of the following categories, or type 'exit':
      -'Games'
      -'Books'
      -'Podcasts'"
      selection = (gets.chomp).downcase
      if selection == "exit"
        return false
      elsif choices.include?(selection)
        importer.add_source("Product Hunt", selection)
        puts "you added the #{selection} tag"
        return true
      else
        puts "I'm sorry, that's not a valid tag, try again!"
      end
    end
  end

  def add_to_stack_overflow
    loop do
      puts "Type in any Stack Overflow tag, or type 'exit':"
      selection = (gets.chomp).downcase
      if selection == "exit"
        return false
      elsif StackOverflowValidator.new(selection).validate
        importer.add_source("Stack Overflow",selection)
        puts "You added the #{selection} tag"
        return true
      else
        puts "I'm sorry, that's not a valid tag, try again!"
      end
    end
  end

  def remove_sources
    puts "Which source would you like to clear selections from?
    -Reddit
    -Product Hunt
    -Stack Overflow"
    loop do
      selection = (gets.chomp).downcase
      if selection == "reddit"
        break if clear_reddit
        puts "make another selection, or type 'exit'"
      elsif selection == "product hunt"
        break if clear_product_hunt
        puts "make another selection, or type 'exit'"
      elsif selection == "stack overflow"
        break if clear_stack_overflow
        puts "make another selection, or type 'exit'"
      elsif selection == 'exit'
        break
      else
        puts "Sorry, I didn't get, please make a valid selection"
      end
    end
  end

  def clear_reddit
    importer.clear_source("Reddit")
    return true
  end

  def clear_product_hunt
    importer.clear_source("Product Hunt")
    return true
  end

  def clear_stack_overflow
    importer.clear_source("Stack Overflow")
    return true
  end

  def exit_program
    puts "Bye!"
  end

end
