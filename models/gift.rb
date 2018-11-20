require 'active_record'

class Gift < ActiveRecord::Base
  belongs_to :wanter, class_name: 'User', foreign_key: 'wanter_id'
  belongs_to :gifter, class_name: 'User', foreign_key: 'gifter_id'

  def site_link
    "/events/lemburgchristmas2018/list/#{wanter.id}/gift/#{id}/"
  end

  def purchased?
    !gifter_id.nil?
  end

  def name
    return self[:name] if id.nil?
    return "An unnamed gift" if self[:name].nil? || self[:name].empty?
    self[:name]
  end
end
