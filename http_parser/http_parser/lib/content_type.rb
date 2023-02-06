class ContentType

    def initialize(resource)
        @resource = resource
        p @resource
        @content_type = ""
    end

    def content_type
        if /.html/ =~ "#{@resource}" || /.htm/ =~ "#{@resource}"
            @content_type += "text/html"
        elsif /.css/ =~ "#{@resource}"
            @content_type += "text/css"
        elsif /.jpeg/ =~ "#{@resource}" || /.jpg/ =~ "#{@resource}"
            @content_type += "image/*"
        elsif /.png/ =~ "#{@resource}"
            @content_type += "image/*"
        end
    end
end