require 'socket'
require_relative "request_handler"
require_relative "http_response"
require_relative "content_type"

# Creates and runs an httpserver
class HTTPServer

    # Creates a getter for router
    attr_reader :router
    
    # Constructor, assigns the instancevariable @port the given parameter, @handler an instance of the RequestHandler class and @router an instance of the Router class
    def initialize(port)
        @port = port
        @handler = RequestHandler.new
        @router = Router.new
    end

    # Runs the HTTPServer
    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"


        while session = server.accept
            data = ""
            while line = session.gets and line !~ /^\s*$/
                data += line
            end
            puts "RECEIVED REQUEST"
            puts "-" * 40
            puts data
            puts "-" * 40 

            #Er HTTP-PARSER tar emot "data"
            request = @handler.parse_request(data)
            # runs the resourse check for resource, type and length
            http_response = HTTPResponse.resource_check(request)

            # If the resource is not static (error status) and is not a favicon, checks if the resource is dynamic
            if http_response.status == 404 && request["resource"] != "/favicon.ico"
                if @router.match_route(request["resource"]) != nil
                    http_response.from_dynamic_route(@router.match_route(request["resource"]))
                end
            end

            # prints http_response
            session.print http_response.print_response


            session.close
        end
    end
end
