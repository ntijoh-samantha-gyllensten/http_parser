class RequestHandler

  def parse_request(request)
    lines = request.split("\n")
    first = lines[0]
    verb, resource, version = first.split(" ")
    {"verb" => verb, "resource" => resource, "version" => version}
  end

end