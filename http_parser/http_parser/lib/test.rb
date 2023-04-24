
require_relative 'router.rb'

@router = Router.new

@router.add_route(:get, '/hello/:name/:mood/:hay') do |name, mood, hay|
    "<h1>Hello, #{name}!, how are you? I'm #{mood}, thanks for asking. #{hay} </h1>"
  end



@router = @router.match_route('/hello/Camomille/bad/hey')
p @router
# route = '/hello/:cat/:name'
# route = route.scan(/(:\w+)/)
# p route[1][0]
