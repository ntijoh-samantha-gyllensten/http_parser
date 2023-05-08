#assigns response output
class HTTPResponse

    attr_reader :status, :content, :length

    def initialize(status, content, length)
        @status = status
        @content = content
        @length = length
    end

    def self.resource_check(request)

        mime_type = ContentType.new(request["resource"])
        mime_type = mime_type.full_type

        if mime_type.to_s.match(/html/)
            resource = "public/html" + request["resource"]
        else
            resource = "public" + request["resource"]
        end
        
        # assigns status
        if File.exist?("#{resource}") && File.directory?("#{resource}") != true
            status = 200
        else
            status = 404
            #sets resource as error page
            resource = "public/html/404.html" 
        end

        # checks if the file type is image or other to use approriate file read
        # Does not show error message if the error is the image, which is good as you still want to display the page, but with the alternative text instead
        if /text/ =~ mime_type.to_s
            content = File.read(resource)
        else
            content = File.binread(resource)
        end

        length = content.length

        return new(status, content, length)
        # Uses the httpresponse class to construct the response
    end

    def from_dynamic_route(content)

        @content = content
        @status = 200
        @mime_type = "text/html"
        @length = @content.length

    end


    def print_response
        output = ""
        output += "HTTP/1.1 #{@status}\r\n" #outputs status
        output += "Content-type: #{@mime_type}\r\n" #outputs content type
        output += "Content-length: #{@length}\r\n" 
        output +=  "\r\n"
        output += @content

    end
end