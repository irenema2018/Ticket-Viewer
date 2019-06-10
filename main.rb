     
require "sinatra"
require "pry"
require "sinatra/reloader"
require "httparty"

enable  :sessions

get '/' do
  erb :index
end

post '/tickets' do

  session[:accountname]=params[:accountname]
  session[:email]=params[:email]
  session[:password]=params[:password]

  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get("https://#{session[:accountname]}.zendesk.com/api/v2/tickets.json?per_page=25", 
                          :basic_auth => auth)

  @tickets = response['tickets']

  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']

  erb :tickets
end

get '/tickets/next_page' do

  next_page_url = session[:next_page_url]

  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get(next_page_url, 
                          :basic_auth => auth)

  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']
                   
  erb :tickets
end

get '/tickets/prev_page' do

  prev_page_url = session[:prev_page_url]

  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get(prev_page_url, 
                          :basic_auth => auth)

  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']
                   
  erb :tickets
end








