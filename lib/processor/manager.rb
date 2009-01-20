module Processor
  class Manager
    class << self
      @@processors = []
      def processors
        @@processors
      end
      
      def register(klass)
        @@processors << klass
      end
    end
  end
end