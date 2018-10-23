require 'sinatra'

get '/home/' do
  require_login

  erb :home, :layout => :layout
end