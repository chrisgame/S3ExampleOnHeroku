require 'net/http'
require 'rspec'

Then /^i should be able to add an image to my bucket$/ do
    uri = URI.parse 'http://sharp-sunrise-7465.heroku.com/'
  http = Net::HTTP.new(uri.host, uri.port)

  data = File.read "#{File.dirname(__FILE__)}/../../test_assets/test.jpeg"

  response, body = http.put('/', data, {'Content-type' => 'image/jpeg'})

  response.code.should == '200'
end
Given /^The app is running$/ do
  puts "I'm just hoping it is at this stage"
end
When /^retrieve it$/ do
  uri = URI.parse 'http://sharp-sunrise-7465.heroku.com/'
  http = Net::HTTP.new(uri.host, uri.port)

  response, body = http.get('/')

  response.code.should == '200'
end