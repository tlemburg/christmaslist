require 'active_record'
require 'bcrypt'
require 'models/gift'

class User < ActiveRecord::Base
  has_many :wanted_gifts, foreign_key: "wanter_id", class_name: "Gift"
  has_many :gifted_gifts, foreign_key: "gifter_id", class_name: "Gift"
  include BCrypt

  def wanted_gifts_for_event(event_id)
    wanted_gifts.all.select{|gift| gift.event_id == event_id}
  end

  def gifted_gifts_for_event(event_id)
    gifted_gifts.all.select{|gift| gift.event_id == event_id}
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def check_password(password_to_check)
    password == password_to_check
  end
end
