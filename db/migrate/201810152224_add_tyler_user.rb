require 'active_record'
require 'models/user'

class AddTylerUser < ActiveRecord::Migration[5.0]
  def up
    User.create(
      :username => 'tyler',
      :password_hash => '$2a$10$vRx5RJJgA.BtNDPdq5s0g.zIBWG7/ysQHplHdXp4nnARl94y1xSiO',
      :name => 'Tyler'
    )
  end

  def down
    User.find_by(:username => 'tyler').delete
  end
end
