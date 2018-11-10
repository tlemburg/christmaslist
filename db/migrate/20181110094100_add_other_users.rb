require 'active_record'
require 'models/user'

class AddOtherUsers < ActiveRecord::Migration[5.0]
  def up
    User.create(
        :username => 'andrea',
        :password_hash => "$2a$10$JFvWbwzQbm4TVKuby2D12eDzjU0OrW9kA71RSL2KWnbZdG0DWltka",
        :name => 'Andrea'
    )
    User.create(
        :username => 'abby',
        :password_hash => "$2a$10$NdOEV2VwQRbq32sTzAZW7.Xilh01M/UrTs0yFG5tG9gVyqHl6xBq.",
        :name => 'Abby'
    )
    User.create(
        :username => 'tim',
        :password_hash => "$2a$10$lenymu7RVkZ3E5Yh9qYwuu4JHwMOtleRszkCgk2Okl.88/3tpl70W",
        :name => 'Dad'
    )
    User.create(
        :username => 'peg',
        :password_hash => "$2a$10$QHVvOwD9c/oWAya9Yh48buCJfI.FGAjIpF1Igg0ov9g94EqOQ2pZK",
        :name => 'Mom'
    )
    User.create(
        :username => 'josh',
        :password_hash => "$2a$10$qo7s2T1BokJI4106QZ53SuXwxCaHfENFkj7QHxpJ1u4QR5r3usxMi",
        :name => 'Josh'
    )
  end

  def down
    User.find_by(:username => 'andrea').delete
    User.find_by(:username => 'abby').delete
    User.find_by(:username => 'tim').delete
    User.find_by(:username => 'peg').delete
    User.find_by(:username => 'josh').delete
  end
end
