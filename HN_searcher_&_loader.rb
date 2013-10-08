require "net/http"
require "uri"
require "json"
require 'launchy'

puts "What do you want to search for?"
search_item = gets.chomp
identifier = URI.parse("http://api.thriftdb.com/api.hnsearch.com/items/_search?limit=5&q=#{search_item}&weights[title]=2.0&weights[username]=0")

http = Net::HTTP.new(identifier.host, identifier.port)
my_request = Net::HTTP::Get.new(identifier.request_uri)
my_response = http.request(my_request)

info = my_response.body

parsed_json = JSON.parse(info)

parsed_json["results"].each do |result|
  url = result["item"]["url"]  
  puts url
  Launchy.open(url) 
end 