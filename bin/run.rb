#!/usr/bin/env ruby

require_relative '../config/environment'



stuff = StackOverflowValidator.new("gibberdygiberish")
# binding.pry
stuff.validate

# master = ImportIO.new
# master.open
# master.todays_stories
# master.selection
