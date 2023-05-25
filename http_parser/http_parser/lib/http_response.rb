# Assigns response output
class HTTPResponse

    # Creates getters for status, content, and length
    attr_reader :status, :content, :length

    # Constructor, assigns the instancebaraibles @status, @content and @length the value of the following parameters
    # 
    # @param status |Number| the status of the resource
    # @param content |Content| the content of the resource
    # @param length |Number| the length of the content
    def initialize(status, content, length)
        @status = status
        @content = content
        @length = length
    end

    # Classmethod, searches for if the requested resource exists and constructs a new object using values it sets for status, content and length
    # 
    # @param request |Hash| the request being checked
    #   * :verb |String| the verb for the request
    #   * :resource |String| the resource of the request
    #   * :version |String| the HTTP version of the request
    # 
    # @return new |Object| returns an object of the HTTPResponse class constructed with the status, content and length values
    def self.resource_check(request)

        mime_type = ContentType.new(request["resource"])
        mime_type = mime_type.full_type

        if mime_type.to_s.match(/html/)
            resource = "public/html" + request["resource"]
        else
            resource = "public" + request["resource"]
        end
        
        # Assigns status the value 200 if the file exists
        if File.exist?("#{resource}") && File.directory?("#{resource}") != true
            status = 200
        else
            # Assigns status the value 404
            status = 404
            # Sets resource as error page
            resource = "public/html/404.html" 
        end

        # checks if the file type is image or other to use approriate file read
        #   Does not show error message if the error is the image, which is good as you still want to display the page, but with the alternative text instead
        if /text/ =~ mime_type.to_s
            content = File.read(resource)
        else
            content = File.binread(resource)
        end

        length = content.length

         # Uses the httpresponse class to construct the response
        return new(status, content, length)
    end

    # Assigns the instance variables @content, @status, @mime_type and @length values if the resource is dynamic
    # 
    # @param content |Content| the content of the resource
    def from_dynamic_route(content)

        @content = content
        @status = 200
        @mime_type = "text/html"
        @length = @content.length

    end

    # Prints the HTTP response
    def print_response
        output = ""
        output += "HTTP/1.1 #{@status}\r\n" #outputs status
        output += "Content-type: #{@mime_type}\r\n" #outputs content type
        output += "Content-length: #{@length}\r\n" 
        output +=  "\r\n"
        output += @content
    end
end