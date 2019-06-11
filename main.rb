     
require "sinatra"
require "sinatra/reloader"
require "httparty"

enable  :sessions

get '/' do
  erb :index
end

get '/error' do
  erb :error
end

get '/tickets' do
  session[:error_message] = 'Something was wrong. Please go back to Home and try again!' 
  redirect '/error'
end

post '/tickets' do
  session[:accountname] = params[:accountname]
  session[:email]       = params[:email]
  session[:password]    = params[:password]

  url = "https://#{session[:accountname]}.zendesk.com/api/v2/tickets.json?per_page=25&include=users"
  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get(url,:basic_auth => auth)

  if response.code != 200
    session[:error_message] = 'Something was wrong. The Zendesk API may not be available or your credentials may not be entered correctly.'
    redirect '/error'
  end

  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']

  @users = {}
  response['users'].each do |user|
    id = user['id']
    name = user['name']
    @users[id] = name
  end

  erb :tickets
end

get '/tickets/next_page' do
  if !session[:next_page_url]
    session[:error_message] = 'There is no next page.'
    redirect '/error'
  end

  next_page_url = session[:next_page_url]
  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get(next_page_url, :basic_auth => auth)

  if response.code != 200
    session[:error_message] = 'Something was wrong. The Zendesk API may not be available or your credentials may not be entered correctly.'
    redirect '/error'
  end                          

  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']

  @users = {}
  response['users'].each do |user|
    id = user['id']
    name = user['name']
    @users[id] = name
  end
                  
  erb :tickets
end

get '/tickets/prev_page' do
  if !session[:prev_page_url]
    session[:error_message] = 'There is no previous page.'
    redirect '/error'
  end

  prev_page_url = session[:prev_page_url]
  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get(prev_page_url, :basic_auth => auth)

  if response.code != 200
    session[:error_message] = 'Something was wrong. The Zendesk API may not be available or your credentials may not be entered correctly.'
    redirect '/error'
  end    

  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']

  @users = {}
  response['users'].each do |user|
    id = user['id']
    name = user['name']
    @users[id] = name
  end
                   
  erb :tickets
end

get '/ticket/:id' do
  if !session[:accountname]
    session[:error_message] = "Unable to get ticket ##{params[:id]}."
    redirect '/error'
  end

  url = "https://#{session[:accountname]}.zendesk.com/api/v2/tickets/#{params[:id]}.json?include=users"
  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get(url, :basic_auth => auth)

  if response.code != 200
    session[:error_message] = "Unable to get ticket ##{params[:id]}."
    redirect '/error'
  end       
                    
  @ticket = response['ticket']
  @users = {}
  response['users'].each do |user|
    id = user['id']
    name = user['name']
    @users[id] = name
  end

  erb :ticket
end








