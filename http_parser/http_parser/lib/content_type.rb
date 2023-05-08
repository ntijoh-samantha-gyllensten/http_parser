# Checks a file's content type
class ContentType

    def initialize(resource)
        @resource = resource
    end

    # method that assigns the content type (MIME) based on the file type
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

    def to_s
        @content_type.to_s
    end
end