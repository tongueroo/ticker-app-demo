require 'rubygems'
require 'logger'

# my dependency
require "#{File.dirname(__FILE__)}/../../lib/processor"

class Ticker < Nanite::Actor
  expose :handle

  def handle(data)
    puts "hi from ticker/handle"
    processor = Processor.new(data)
    processor.run
  end
end

Nanite.register(Ticker.new)