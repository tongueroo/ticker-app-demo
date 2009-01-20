require 'rubygems'
require 'nokogiri'
require 'couchrest'
require 'logger'
here = File.dirname(__FILE__)
require here + '/manager'

module Processor
  class Generic
    def initialize(data)
      puts "data : #{data.inspect}"
      # @data = data
      # @db = CouchRest.database!("http://127.0.0.1:5984/pa_sports")
      @logger = Logger.new("#{File.dirname(__FILE__)}/log/processor-scoreboard.txt")
    end
    
    def run
      parse
      save
    end
    
    def parse
      @record = {}
      @record["processor"] = self.class.name
      @record["raw"] = @data
    end
    
    def save
      @logger.info(@record)
      # @db.save(@record)
    end

    class << self
      def process?
        true
      end
    end
  end
end

Processor::Manager.register(Processor::Generic)

if $0 == __FILE__
  processor = Processor::Generic.new(open("#{File.dirname(__FILE__)}/fixtures/scoreboard.xml").read)
  processor.run
end