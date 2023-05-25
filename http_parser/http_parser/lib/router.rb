require 'socket'

# Handles dynamic routes
class Router

    # Constructor, assigns the instancevariable @routes and empty array
    def initialize
        @routes = []
    end

    # Isolates the parameters of dynamic routes
    # 
    # @param route |String| the route
    # 
    # @return |Array| an array containing the isolated parameter values of the block
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

    # Adds route to array (instancevaraible @routes) of dynamic routes
    # 
    # @param verb |String| the verb for the request
    # @param route |String| the route
    # @param &code |Block| the code for the content of the route
    def add_route(verb, route, &code)
        @routes << {verb: verb, route: route, code: code}
    end

    # Matches input route to array of saved dynamic routes
    # 
    # @param input_route |String| route from request
    # 
    # @return |Content| the code saved within the dynamic route
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