require 'net/http'
require 'uri'

uri = URI.parse('https://api.github.com/user')

http = Net::HTTP.new( uri.host, uri.port )
http.use_ssl = true

req = Net::HTTP::Get.new( uri.request_uri )
req.basic_auth( 'user_fill_here', 'password_fill_here' )

r = http.request( req )

puts r
