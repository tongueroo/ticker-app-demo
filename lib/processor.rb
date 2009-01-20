require 'logger'

APP_ROOT = "#{File.dirname(__FILE__)}/.."

class Processor
  def initialize(data)
    @data = data
    @logger = Logger.new("#{APP_ROOT}/log/processor.log")
  end
  
  def run
    puts "Processor#run"
    @logger.info(@data)
  end
end

