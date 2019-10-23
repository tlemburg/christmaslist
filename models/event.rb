require 'active_record'

class Event < ActiveRecord::Base
  has_many :gifts
end
