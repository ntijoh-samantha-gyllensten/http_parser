require 'socket'

class Router

    def initialize
        @routes = []
    end

    def params(route)
        params = route.scan(/(\/\w+)/)
        params.delete_at(0)
        i = 0
        while i < params.length
            params[i] = params[i][0]
            params[i] = params[i].delete('/')
            i += 1
        end
        return params
    end

    def add_route(verb, route, &code)
        @routes << {verb: verb, route: route, code: code}
    end

    def match_route(input_route)

        route = @routes.find do |route| 

            if route[:route].match(/:/)
                route_exp = route[:route].gsub(/\/:\w+/, '\/\w+')
                route_exp = Regexp.new(route_exp)
                if input_route.match(route_exp)
                    route = input_route
                end
            elsif route[:route] == input_route
                route = input_route
            end

        end

        if route != nil
            
            params = params(input_route)
            return route[:code].call(params)

        else
            return nil
        end

    end

end