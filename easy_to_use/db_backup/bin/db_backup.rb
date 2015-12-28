#!/usr/bin/env ruby

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|

  #Creates a switch
  opts.on("-i", "--iteration") do
    options[:iteration] = true
  end

  # Creates a flag
  opts.on("-u USER", /^.+\..+$/) do |user|
    options[:user] = user
  end

  opts.on("-p PASSWORD") do |password|
    options[:password] = password
  end

  # you dont have to use always regular expressions for validation. By including
  # an Array you can indicate the complete list of acceptable values.
  # By using a Hash will use the keys as acceptable values and send the mapped
  # value to the block.
  servers = {
    'dev'  => '127.0.01',
    'qa'   => 'qa001.example.com',
    'prod' => 'www.example.com'
  }

  opts.on("--server SERVER", servers) do |address|
    options[:server] = address
  end

  # Also you can pass a classname in the argument list, `OptionParser` will
  # attempt to convert the string from the command line an instance of the given
  # class
end

# Difference between Swutch and flag, when parsing arguments
# if a string is passed stars with a dash followed by
# one or more nonspace characters, is treated as a switch. If there is a space
# and another string it's treated as a flag

option_parser.parse!

database = ARGV.shift

unless options[:iteration].nil?
  backup_file = database + Time.now.strftime('%Y%m%d')
else
  backup_file = database + options[:iteration].to_s
end
mysqldump = "mysqldump -u#{options[:username]} - p#{options[:password]} #{database}"
`#{mysqldump} > #{backup_file}.sql`
`gzip #{backup_file}.sql`

