require 'active_record'

class CreateDatabase < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :name
    end

    create_table :gifts do |t|
      t.integer :wanter_id
      t.integer :gifter_id
      t.string :name
      t.text :description
      t.string :link
      t.string :image_url
    end
  end
end
