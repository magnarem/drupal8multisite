#!/usr/bin/env ruby

require "yaml"

def check_file(filename)
  YAML.parse_file(filename)
  puts "OK"
  0
rescue Psych::SyntaxError => ex
  puts "Error#{ex.message[/: .+/]}"
  1
end

exit_code = 0
max_filename_length = ARGV.max_by(&:size).size

ARGV.each do |filename|
  printf "%-*s  ", max_filename_length, filename
  exit_code |= check_file(filename)
end

exit exit_code
