#!/usr/bin/env ruby

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|

  #Creates a switch
  opts.on("-i", "--iteration") do
    options[:iteration] = true
  end

  # Creates a flag
  opts.on("-u USER") do |user|
    options[:user] = user
  end

  opts.on("-p PASSWORD") do |password|
    options[:password] = password
  end
end

# Difference between Swutch and flag, when parsing arguments
# if a string is passed stars with a dash followed by
# one or more nonspace characters, is treated as a switch. If there is a space
# and another string it's treated as a flag

option_parser.parse!
puts options.inspect
