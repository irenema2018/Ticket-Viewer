require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

require_relative 'main'
  
class MainTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application 
  end
  
  def test_get
    get '/'
    assert last_response.ok?
  end
end
