require 'rubygems'
require 'eventmachine'
require 'logger'
require 'nanite'

class TickerDispatcher
  @@i = 0
  
  def logger
    @logger ||= Logger.new("#{File.dirname(__FILE__)}/log/dispatcher-log.txt")
  end
  
  def handle(data)
    # start up a new mapper with a ping time of 15 seconds
    @@started ||= Nanite.start :mapper => true, :host => 'localhost',
                 :user => 'mapper', :pass => 'testing',
                 :vhost => '/nanite', :log_level => 'info'

    Nanite.request("/ticker/handle", data) do |res|
      p res
    end
    
    @@i += 1
    logger.info("@@i : #{@@i}")
  end
end

module TickerListener
  def receive_data data
    dispatcher = TickerDispatcher.new
    dispatcher.handle(data)
    
    puts "done operating on the data: #{data.inspect}"
  end
end

EM.run do
  EM.start_server "localhost", 9100, TickerListener
end