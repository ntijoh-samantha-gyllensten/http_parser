require 'socket'
require_relative 'router.rb'
require_relative 'http_server.rb'
require_relative "request_handler"


server = HTTPServer.new(4567)
server.start