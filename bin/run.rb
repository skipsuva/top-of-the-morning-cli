#!/usr/bin/env ruby

require_relative '../config/environment'

# binding.pry

master = ImportIO.new
master.open
master.todays_stories
master.selection
