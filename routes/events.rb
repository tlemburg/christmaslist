require 'sinatra'
require 'models/gift'

helpers do
  def load_list_user(id)
    # check user exists
    @list_user = User.find_by(:id => id)
    not_found if @list_user.nil?
  end

  def load_gift(gift_id)
    # check gift exists and is under that user
    @gift = Gift.find_by(:id => gift_id)
    not_found if @gift.nil?
    not_found if @gift.wanter.id != @list_user.id
  end
end

get '/events/lemburgchristmas2018/?' do
  require_login
  erb :event_home, :layout => :layout
end

get '/events/lemburgchristmas2018/add/?' do
  require_login
  @gift = Gift.new
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

get '/events/lemburgchristmas2018/list/:user_id/?' do
  require_login
  load_list_user(params[:user_id])
  redirect '/events/lemburgchristmas2018/' if @user == @list_user

  erb :event_list, :layout => :layout
end

get '/events/lemburgchristmas2018/list/:user_id/gift/:gift_id/?' do
  require_login
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  erb :gift_detail, :layout => :layout
end

post '/events/lemburgchristmas2018/list/:user_id/gift/:gift_id/?' do
  require_login
  load_list_user(params[:user_id])
  redirect '/events/lemburgchristmas2018/' if @user == @list_user

  load_gift(params[:gift_id])

  if params[:cancel] == 'cancel' && @user.id == @gift.gifter_id
    @gift.gifter = nil
    @gift.save
    flash :success, "Saved! You're no longer buying #{@gift.name} for #{@list_user.name}."
  else
    @gift.gifter = @user
    @gift.save
    flash :success, "Saved! You're marked as buying #{@gift.name} for #{@list_user.name}."
  end
  redirect "/events/lemburgchristmas2018/list/#{params[:user_id]}/"
end

get '/events/lemburgchristmas2018/list/:user_id/gift/:gift_id/edit/?' do
  require_login
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  erb :add_gift, :layout => :layout
end

post '/events/lemburgchristmas2018/list/:user_id/gift/:gift_id/edit/?' do
  require_login
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  @gift.update!(name: params[:name],
                description: params[:description],
                link: params[:link],
                image_url: params[:image_url]
  )
  flash :success, "Your gift #{@gift.name} has been updated!"
  redirect '/events/lemburgchristmas2018/'
end

post '/events/lemburgchristmas2018/list/:user_id/gift/:gift_id/delete/?' do
  require_login
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  if @user == @list_user
    @gift.delete
  end
  flash :success, "Your gift #{@gift.name} has been deleted!"
  redirect '/events/lemburgchristmas2018/'
end