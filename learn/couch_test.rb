require 'rubygems'
require 'couchrest'

@db = CouchRest.database!("http://127.0.0.1:5984/couchrest-test")
response = @db.save({'value' => 'another value'})
doc = @db.get(response['id'])
puts doc.inspect


puts "notfound: #{@db.get('nofound')}"