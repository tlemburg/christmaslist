require 'sinatra'
require 'models/event'
require 'models/gift'

helpers do
  def load_event(slug)
    @event = Event.find_by(:slug => slug)
    not_found if @event.nil?
  end

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

get '/events/:event_slug/?' do
  require_login
  load_event(params[:event_slug])
  erb :event_home, :layout => :layout
end

get '/events/:event_slug/add/?' do
  require_login
  load_event(params[:event_slug])
  @gift = Gift.new
  erb :add_gift, :layout => :layout
end

post '/events/:event_slug/add/?' do
  require_login
  load_event(params[:event_slug])
  new_gift = @user.wanted_gifts.create(
           name: params[:name],
           description: params[:description],
           link: params[:link],
           image_url: params[:image_url],
           event_id: @event.id
  )

  flash :success, "Gift #{new_gift.name} was added to your list."
  redirect "/events/#{params[:event_slug]}/"
end

get '/events/:event_slug/list/:user_id/?' do
  require_login
  load_event(params[:event_slug])
  load_list_user(params[:user_id])
  redirect "/events/#{params[:event_slug]}/" if @user == @list_user

  erb :event_list, :layout => :layout
end

get '/events/:event_slug/list/:user_id/gift/:gift_id/?' do
  require_login
  load_event(params[:event_slug])
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  erb :gift_detail, :layout => :layout
end

post '/events/:event_slug/list/:user_id/gift/:gift_id/purchased/?' do
  require_login
  load_event(params[:event_slug])
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  if params[:mark_purchased] == 'mark_purchased'
    @gift.purchased = true
    @gift.save
    message = "Gift marked!"
  elsif params[:mark_purchased] == 'unmark_purchased'
    @gift.purchased = false
    @gift.save
    message = "Gift unmarked."
  end
  return {success: message}.to_json
end

post '/events/:event_slug/list/:user_id/gift/:gift_id/?' do
  require_login
  load_event(params[:event_slug])
  load_list_user(params[:user_id])
  redirect "/events/#{params[:event_slug]}/" if @user == @list_user

  load_gift(params[:gift_id])

  if params[:cancel] == 'cancel' && @user.id == @gift.gifter_id
    @gift.gifter = nil
    @gift.purchased = false
    @gift.save
    flash :success, "Saved! You're no longer marked down to buy #{@gift.name} for #{@list_user.name}."
  elsif params[:mark] == 'mark'
    @gift.gifter = @user
    @gift.save
    flash :success, "Saved! You're marked as buying #{@gift.name} for #{@list_user.name}."
  elsif params[:mark_purchased] == 'mark_purchased'
    @gift.purchased = true
    @gift.save
  elsif params[:mark_purchased] == 'unmark_purchased'
    @gift.purchased = false
    @gift.save
  end
  redirect "/events/#{params[:event_slug]}/list/#{params[:user_id]}/"
end

get '/events/:event_slug/list/:user_id/gift/:gift_id/edit/?' do
  require_login
  load_event(params[:event_slug])
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  erb :add_gift, :layout => :layout
end

post '/events/:event_slug/list/:user_id/gift/:gift_id/edit/?' do
  require_login
  load_event(params[:event_slug])
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  @gift.update!(name: params[:name],
                description: params[:description],
                link: params[:link],
                image_url: params[:image_url]
  )
  flash :success, "Your gift #{@gift.name} has been updated!"
  redirect "/events/#{params[:event_slug]}/"
end

post '/events/:event_slug/list/:user_id/gift/:gift_id/delete/?' do
  require_login
  load_event(params[:event_slug])
  load_list_user(params[:user_id])
  load_gift(params[:gift_id])

  if @user == @list_user
    @gift.delete
  end
  flash :success, "Your gift #{@gift.name} has been deleted!"
  redirect "/events/#{params[:event_slug]}/"
end
