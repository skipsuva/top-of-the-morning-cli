#!/usr/bin/env ruby

require_relative '../config/environment'

binding.pry

ImportController.new.pull_stories
