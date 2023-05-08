require 'socket'
require 'erb'
require_relative 'lib/router.rb'
require_relative 'lib/http_server.rb'
require_relative "lib/request_handler"


server = HTTPServer.new(4567)




server.router.add_route(:get, '/hello') do
    ERB.new(File.read('views/hello.erb')).result(binding)
end

server.router.add_route(:get, '/hello/:name/:mood/:hay') do |name, mood, hay|
   @mood = mood
   @name = name
   @hay = hay
   ERB.new(File.read('views/snort.erb')).result(binding)
end


server.start