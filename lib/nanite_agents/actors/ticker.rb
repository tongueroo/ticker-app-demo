here = File.dirname(__FILE__)
require here + "/../../processor/manager"
require here + "/../../processor/generic"

class Ticker < Nanite::Actor
  
  expose :handle, :time

  def handle(data)
    Processor::Manager.processors.each do |klass|
      if (klass.process?)
        puts "processing data with processor: #{klass.name}"
        processor = klass.new(data)
        processor.run
      end
    end
  end
  
  def time(data)
    Time.now
  end

end

Nanite.register(Ticker.new)

