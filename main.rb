     
require "sinatra"
require "pry"
require "sinatra/reloader"
require "httparty"

get '/' do
  erb :index
end

get '/tickets' do
  auth = {:username => "irene.ma@outlook.com", :password => "temp"}
  response = HTTParty.get("https://irene.zendesk.com/api/v2/tickets.json?per_page=2", 
                          :basic_auth => auth)
                          
  puts(response)
  puts(response['tickets'])
 
  erb :tickets
end







