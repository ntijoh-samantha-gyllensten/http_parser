#assigns response output
class HTTPResponse

    def initialize(resource, length, type)
        @length = length
        @resource = resource
        @type = type

        # assigns status (possibly move to seperate method?)
        if File.exist?("#{@resource}")
            @status = 200
        else
            @status = 404
            resource = "./http_parser/html/404.html" #sets resource as error page
        end
    end

    def print_response

        output = ""
        output += "HTTP/1.1 #{@status}\r\n" #outputs status
        output += "Content-type: #{@type}\r\n" #outputs content type
        # output += "Content-length: #{@length}\r\n" #temporarily disabled as it was clashing with img and css
        output +=  "\r\n"

        # checks if the file type is image or other to use approriate file read
        if @type == "image/*"
            output += File.binread(@resource)
        else
            output += File.read(@resource)
        end

    end
end