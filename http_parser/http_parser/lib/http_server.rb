require 'socket'
# require 'mime/types'
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

        p request["resource"]
        if request["resource"] != "/favicon.ico"
            type = ContentType.new(request["resource"])
            type = type.content_type
            p type
            type = type.split("/")
            type = type[1]
            p type

            if type != "*"
                full_resource = "#{type}" + request["resource"]
            else
                p "HWEW"
                p request["resource"]
                full_resource = "." + request["resource"]
            end
            p full_resource

            # length = ContentLength.new(full_resource)
            # length = length.length
            length = 0

            type = ContentType.new(full_resource)
            type = type.content_type
            p type

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
            run = resource_check(request)

            if request["resource"] != "/favicon.ico"
                session.print run.print_response
            end

            session.close
        end
    end
end


# class ContentType

# end
