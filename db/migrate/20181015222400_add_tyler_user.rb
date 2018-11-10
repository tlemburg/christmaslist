require 'active_record'
require 'models/user'

class AddTylerUser < ActiveRecord::Migration[5.0]
  def up
    User.create(
      :username => 'tyler',
      :password_hash => '$2a$10$BMSQhrxHOYMJaJO7aE1YpOVxZoiH0CcCp38zOY9Mj.6y2lScbj6c.',
      :name => 'Tyler'
    )
  end

  def down
    User.find_by(:username => 'tyler').delete
  end
end
