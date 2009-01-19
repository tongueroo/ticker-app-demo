#!/usr/bin/env ruby

require 'rubygems'
require 'eventmachine'

# this mocks a the pa sports ticker java class

module TickerTalker
  def post_init
    file = open("#{File.dirname(__FILE__)}/data.xml")
    @data = file.read
    puts "sending data : #{@data}"
    send_data @data
  end
end

EM.run do
  EM.add_periodic_timer(1) do
    EM.connect 'localhost', 9100, TickerTalker
  end
end

