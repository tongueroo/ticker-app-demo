require 'rubygems'
require 'eventmachine'

require 'logger'
require 'nanite'

here = File.dirname(__FILE__)
# require here + "/processor/manager"
# require here + "/processor/scoreboard"
# require here + "/processor/generic"

class TickerDispatcher
  def handle(data)
    # start up a new mapper with a ping time of 15 seconds
    @@started ||= Nanite.start :mapper => true, :host => 'localhost',
                 :user => 'mapper', :pass => 'testing',
                 :vhost => '/nanite', :log_level => 'info'

    Nanite.request("/ticker/handle", data) do |res|
      p res
    end
  end
end

module TickerListener
  def receive_data data
    dispatcher = TickerDispatcher.new
    dispatcher.handle(data)
    
    puts "done operating on the data"
  end
end

module TickerRunner
  def start(opts)
    @host = opts[:host] || '127.0.0.1'
    @port = opts[:port] || 9600
    
    daemonize(opts[:log_file] || "#{File.dirname(__FILE__)}/../log/ticker_runner.log") if opts[:daemonize]

    EM.start_server @host, @port, TickerListener
  end
  
  protected
  def daemonize(log_file)
    exit if fork
    Process.setsid
    exit if fork
    $stdin.reopen("/dev/null")
    $stdout.reopen(log_file, "a")
    $stderr.reopen($stdout)
  end

  extend self
end