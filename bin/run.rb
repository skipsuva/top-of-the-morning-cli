#!/usr/bin/env ruby

require_relative '../config/environment'



# data = YAML.load_file("./config/sources.yml")
# data["Reddit"] << data
# File.open("./config/sources.yml", 'w') { |f| YAML.dump(data, f) }

# stuff = StackOverflowValidator.new("gibberdygiberish")
# binding.pry
# stuff.validate

master = ImportIO.new
master.begin
master.todays_stories
master.selection
