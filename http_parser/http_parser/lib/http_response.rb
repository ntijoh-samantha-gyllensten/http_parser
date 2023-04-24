#assigns response output
class HTTPResponse

    attr_reader :status, :content, :length

    def initialize(status, content, length)
        @status = status
        @content = content
        @length = length
    end

    def self.resource_check(request)
        
        # if request["resource"] != "/favicon.ico"
            # checks content type using the class ContentType in content_type 
            mime_type = ContentType.new(request["resource"])
            mime_type_second = mime_type.second_type
            # mime_type_full = mime_type.full_type
    
            if "*" == "#{mime_type_second}"
                resource = "../public/" + request["resource"]
            else
                resource = "../public/#{mime_type_second}" + request["resource"]
            end
            
             # assigns status (possibly move to seperate method?)
            if File.exist?("#{resource}") && File.directory?("#{resource}") != true
                status = 200
            else
                status = 404
                resource = "../public/html/404.html" #sets resource as error page
            end

            # checks if the file type is image or other to use approriate file read
            if /text/ =~ "#{mime_type}"
                content = File.read(resource)
            else
                content = File.binread(resource)
            end
            length = content.length

            return new(status, content, length)
            # Uses the httpresponse class to construct the response
            
        # end
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
        output += "Content-length: #{@length}\r\n" #temporarily disabled as it was clashing with img and css
        output +=  "\r\n"
        output += @content

    end
end