class ContentLength

    def initialize(resource)
        @resource = resource
        @file_length = File.size(@resource)
    end

    def length()  
        @file_length  
    end

end
