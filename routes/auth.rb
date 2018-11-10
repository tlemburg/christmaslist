require 'sinatra'

helpers do
  def require_login
    if @user.nil?
      redirect '/'
    end
  end

  def bad_login
    flash :danger, 'Incorrect username/password combination.'
    redirect '/login/'
  end

  def logout
    session.clear
    redirect '/'
  end
end

get '/login/?' do
  if @user.nil?
    erb :login, :layout => :layout
  else
    redirect '/events/lemburgchristmas2018/'
  end
end

post '/login/?' do
  user = User.find_by(:username => params[:username])
  bad_login if user.nil?
  bad_login unless user.check_password(params[:password])
  session[:user_id] = user.id
  redirect '/events/lemburgchristmas2018/'
end

get '/logout/?' do
  logout
end

post '/logout/?' do
  logout
end
