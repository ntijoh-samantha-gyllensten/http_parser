# Checks a file's content type
class ContentType

    # Constructor, assigns the instancevariable @resource the value of the parameter
    # 
    # @param resource |String| the resource passed into the class
    def initialize(resource)
        @resource = resource
    end

    # Method that assigns the content type (MIME) based on the file type and assigns it to the instancevariable @content_type
    def full_type
        if /.html/ =~ "#{@resource}" || /.htm/ =~ "#{@resource}"
            @content_type = "text/html"
        elsif /.css/ =~ "#{@resource}"
            @content_type = "text/css"
        elsif /.jpeg/ =~ "#{@resource}" || /.jpg/ =~ "#{@resource}"
            @content_type = "image/*"
        elsif /.png/ =~ "#{@resource}"
            @content_type = "image/*"
        elsif /.ico/ =~ "#{@resource}"
            @content_type = "image/*"
        end
    end

    #Method that converts the instancevariable @content_type to a string
    def to_s
        @content_type.to_s
    end
end