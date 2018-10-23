require 'sinatra'

get '/events/lemburgchristmas2018/?' do
  require_login

  erb :event_home, :layout => :layout
end

get '/events/lemburgchristmas2018/list/:user_id/?' do
  require_login
  #check user exists
  @list_user = User.find_by(:id => params[:user_id])
  not_found if @list_user.nil?
  redirect '/events/lemburgchristmas2018/' if @user == @list_user

  erb :event_list, :layout => :layout
end

get '/events/lemburgchristmas2018/add/?' do
  require_login
  erb :add_gift, :layout => :layout
end

post '/events/lemburgchristmas2018/add/?' do
  require_login
  new_gift = @user.wanted_gifts.create(
           name: params[:name],
           description: params[:description],
           link: params[:link],
           image_url: params[:image_url]
  )

  flash :success, "Gift #{new_gift.name} was added to your list."
  redirect '/events/lemburgchristmas2018/'
end