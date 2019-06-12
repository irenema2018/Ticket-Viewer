require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'
require 'io/console'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

require_relative 'main'
  
class MainTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application 
  end
  
  def test_index
    get '/'
    assert last_response.ok?
  end

  def test_ticket_list 
    print 'Enter Zendesk account name: '
    accountname = gets.chomp

    print 'Enter email: '
    email = gets.chomp

    print 'Enter password: '
    password = STDIN.noecho(&:gets).chomp # This will not show the password
    puts

    credentials = {
      :accountname => accountname,
      :email => email,
      :password => password
    }

    post '/tickets', credentials 

    assert last_response.ok?
    assert last_response.body.include?('Assignee')
    assert !last_response.body.include?('Prev')
    assert last_response.body.include?('Next')

    get '/tickets/next_page' # Go to the second page

    assert last_response.ok?
    assert last_response.body.include?('Assignee')
    assert last_response.body.include?('Prev')
    assert last_response.body.include?('Next')

    get '/tickets/prev_page' # Go to the first page

    assert last_response.ok?
    assert last_response.body.include?('Assignee')
    assert !last_response.body.include?('Prev') # No Prev on the first page
    assert last_response.body.include?('Next')

    get '/ticket/1'

    assert last_response.ok?
    assert last_response.body.include?('Created Date')
    assert last_response.body.include?('Description')
    assert !last_response.body.include?('Prev') # Do not expect to see Prev
    assert !last_response.body.include?('Next') # Do not expect to see Next
  end  
end
