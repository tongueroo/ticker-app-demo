require 'rubygems'
require 'cobravsmongoose'

class JsonConvertor
  def initialize(xml)
    @xml = xml
  end
  attr_reader :hash, :json
  attr_accessor :xml
  
  def run
    @hash = CobraVsMongoose.xml_to_hash(@xml)
    @json = CobraVsMongoose.xml_to_json(@xml)
  end
end


######################################################################
if $0 == __FILE__
  xml = '<alice><bob>charlie</bob><bob>david</bob></alice>'
  convertor = JsonConvertor.new(xml)
  json = convertor.run
  p json
end