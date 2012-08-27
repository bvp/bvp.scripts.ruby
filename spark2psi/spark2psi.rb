#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-
require "rubygems"
require "crack"

#Dir.foreach("c:\\Users\\sysadmin2\\AppData\\Roaming\\Spark\\user\\sysadmin2\@server\\transcripts") do |f|
#  puts f
#end

def convertSpark2Psi(input_filename, output_folder)
  sparkLogFile = "test1@server.xml"
  input_file = File.open(sparkLogFile)
  parsed_xml = Crack::XML.parse(input_file.read)

  messages = parsed_xml["transcript"]["messages"]["message"]

  File.open("test1.log", "w") do |f|
    _to = nil
    messages.each do |message_xml|
      case message_xml['from']
      when /test1/
        _to = "from"
      else
        _to = "to"
      end
      f.puts "|#{message_xml['date']}|1|#{_to}|N---|#{message_xml['body']}"
    end
  end

  input_file.close
end

have_string = "test1@server.xml"
p_str = have_string.split(/[\.?@]+/)
convertSpark2Psi(have_string, ".")
puts p_str[0]+"_at_"+p_str[1]+".history2psi"
