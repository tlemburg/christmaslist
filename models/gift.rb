require 'active_record'

class Gift < ActiveRecord::Base
  belongs_to :wanter, class_name: 'User', foreign_key: 'wanter_id'
  belongs_to :gifter, class_name: 'User', foreign_key: 'gifter_id'
end