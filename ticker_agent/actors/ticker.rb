require 'rubygems'
require 'logger'

APP_ROOT = "#{File.dirname(__FILE__)}/../.."

class Processor
  def initialize(data)
    @data = data
    @logger = Logger.new("#{APP_ROOT}/log/processor-log.txt")
  end
  
  def run
    puts "Processor#run"
    @logger.fatal(@data)
  end
end

class Ticker < Nanite::Actor
  expose :handle

  def handle(data)
    puts "hi from ticker/handle"
    puts "data : #{data}"
    processor = Processor.new(data)
    processor.run
  end
end

Nanite.register(Ticker.new)