require_relative("lib/http_server")

server = HTTPServer.new(4567)
server.start