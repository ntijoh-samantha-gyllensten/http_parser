# require 'byebug'
require 'socket'

class HTTPResponse

    def initialize(resource, length, type)
        @status = 0
        @length = length
        @resource = resource
        @type = type
        # p "Length:"
        # p @length
        # p "RESOURCE"
        # p @resource
        # byebug
        # p "#{File.read(@resource)}"
        if File.exist?("#{@resource}")
            # if resource =~ /.html/
            @status = 200
            # end
        else
            @status = 404
            resource = "./http_parser/html/404.html"
        end
    end

    def print_response

        # fileread = File.read(@resource)

        # if request["resource"] != "/favicon.ico"
        #     session.print("HTTP/1.1 #{@status}\r\n")
        #     session.print("Content-Type: #{@type}\r\n")
        #     session.print("Content-Length: #{@length}\r\n")
        #     session.print("\r\n")
        #     session.print("#{fileread}")
        # end
        output = ""
        output += "HTTP/1.1 #{@status}\r\n"
        output += "Content-type: #{@type}\r\n"
        # output += "Content-length: #{@length}\r\n"
        output +=  "\r\n"
        if @type == "image/*"
            output += File.binread(@resource)
        else
            output += File.read(@resource)
        end
    end
end