# Handles requests
class RequestHandler

  # Parses an HTTP request
  # 
  # @param request |HTTP Request| the http request
  # 
  # @return |Hash|
  #   * :verb |String| the verb for the request
  #   * :resource |String| the resource of the request
  #   * :version |String| the HTTP version of the request
  def parse_request(request)
    lines = request.split("\n")
    first = lines[0]
    verb, resource, version = first.split(" ")
    {"verb" => verb, "resource" => resource, "version" => version}
  end

end

