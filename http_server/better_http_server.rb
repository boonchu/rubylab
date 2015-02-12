#! /usr/bin/env ruby

require 'socket'
require 'uri'

WEB_ROOT = './webdocs'

CONTENT_TYPE_MAPPING = {
	'html'	=> 'text/html',
	'txt'	=> 'text/plain',
	'png'	=> 'image/png',
	'jpg'	=> 'image/jpeg',
	'bin'	=> 'application/octet-stream'
}

DEFAULT_CONTENT_TYPE = 'application/octet-stream'

def content_type(path)
	ext = File.extname(path).split(".").last
	CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
end

def request_f(request)
	uri	= request.split(" ")[1]
	path	= URI.unescape(URI(uri).path)
	
	clean	= []
	# split path into components
	parts	= path.split("/")

	parts.each do |part|
		# skip any empty or current directory '.'
		next if part.empty? || part == '.'
		# if path contain '..', remove it
		part == '..' ? clean.pop : clean << part
	end

	File.join(WEB_ROOT, *clean)
end

server = TCPServer.new('localhost', 8080)

# loop infinitely
loop do
	socket = server.accept
	# read first line of request	
	request = socket.gets
	# log debugging to console
	STDERR.puts request
	
	path = request_f(request)

	if File.exist?(path) && !File.directory?(path) 
	    File.open(path, "rb") do |file|
		socket.print "HTTP/1.1 200 OK\r\n" +
			"Content-Type: #{content_type(file)}\r\n" +
			"Content-Length: #{file.size}\r\n" +
			"Connection: close\r\n"

		socket.print "\r\n"
	
		IO.copy_stream(file, socket)
	    end	
	else
	    message = "File not found\n"
	  	socket.print "HTTP/1.1 404 Not Found\r\n" +
			"Content-Type: text/plain\r\n" +
			"Content-Length: #{message.size}\r\n" +
			"Connection: close\r\n" 
		socket.print "\r\n"
		socket.print message
	end

	socket.close
end
