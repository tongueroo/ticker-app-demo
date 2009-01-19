require 'rubygems'
require 'logger'

app_root = "#{File.dirname(__FILE__)}/../.."

class Processor
  def initialize(data)
    @data = data
    @logger = Logger.new("#{app_root}/log/processor-log.txt")
  end
  
  def run
    @logger.info(@data)
  end
end

class Ticker < Nanite::Actor
  expose :handle

  def handle(data)
    processor = Processor.new(data)
    processor.run
  end
end

Nanite.register(Ticker.new)