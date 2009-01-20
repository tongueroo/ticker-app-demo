require 'rubygems'
require 'eventmachine'

module EchoServer
  def receive_data data
    puts ">>>puts you sent"
    puts data
    # send_data ">>>you sent: #{data}"
    close_connection if data =~ /quit/i
  end
end

EventMachine::run {
  EventMachine::start_server "127.0.0.1", 9600, EchoServer
}
