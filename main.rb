     
require "sinatra"
require "pry"
require "sinatra/reloader"
require "httparty"

enable  :sessions

get '/' do
  erb :index
end

get '/tickets' do
  auth = {:username => "irene.ma@outlook.com", :password => "temp"}
  response = HTTParty.get("https://irene.zendesk.com/api/v2/tickets.json?per_page=25", 
                          :basic_auth => auth)

  @tickets = response['tickets']

  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']

  erb :tickets
end

get '/tickets/next_page' do

  next_page_url = session[:next_page_url]

  auth = {:username => "irene.ma@outlook.com", :password => "temp"}
  response = HTTParty.get(next_page_url, 
                          :basic_auth => auth)

  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']
                   
  erb :tickets
end

get '/tickets/prev_page' do

  prev_page_url = session[:prev_page_url]

  auth = {:username => "irene.ma@outlook.com", :password => "temp"}
  response = HTTParty.get(prev_page_url, 
                          :basic_auth => auth)

  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']
                   
  erb :tickets
end








