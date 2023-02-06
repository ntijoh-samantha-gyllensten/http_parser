require 'socket'
require_relative "request_handler"
require_relative "http_response"
require_relative "content_length"
require_relative "content_type"

class HTTPServer

    def initialize(port)
        @port = port
        @handler = RequestHandler.new
    end

    def resource_check(request)

        if request["resource"] != "/favicon.ico"
            # checks content type using the class ContentType in content_type 
            type = ContentType.new(request["resource"])
            type = type.content_type
            # takes the latter part of the MIME type to identify what output is appropriate
            type = type.split("/")
            type = type[1]

            if type != "*"
                full_resource = "#{type}" + request["resource"]
            else
                full_resource = "." + request["resource"]
            end

            # length was affecting css and image file reads, temporarily disabled
            # length = ContentLength.new(full_resource)
            # length = length.length
            length = 0

            # Reassigns the variable type as the full MIME type
            type = ContentType.new(full_resource)
            type = type.content_type

            # Uses the httpresponse class to construct the response
            HTTPResponse.new(full_resource, length, type)
        end
    end

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
            run = resource_check(request)

            # checks that the resource being requested is not favicon, as the feature is not supported yet
            if request["resource"] != "/favicon.ico"
                session.print run.print_response
            end

            session.close
        end
    end
end