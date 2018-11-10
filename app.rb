require 'sinatra'
require 'sinatra/cookies'
require 'models/user'

configure :production do
  set :show_exceptions, false
end

use Rack::Session::Cookie, :key => 'rack.session',
    :path => '/',
    :domain => (settings.development? ? nil : '.lemburgchristmaslist.com'),
    :secret => 'malganiskelthuzadanubarakarthas',
    :old_secret => 'malganiskelthuzadanubarakarthas'

helpers do
  def flash(level, message)
    session[:flash_messages] ||= []
    session[:flash_messages] << {
      :level => level,
      :message => message
    }
  end
end

before do
  session[:init] = true
  session[:flash_messages] ||= []

  if session.has_key?(:user_id)
    @user = (User.find(session[:user_id]) rescue nil)
  end
end

get '/' do
  redirect '/login/'
end

Dir.glob("./routes/*.rb").each {|route| require route}
