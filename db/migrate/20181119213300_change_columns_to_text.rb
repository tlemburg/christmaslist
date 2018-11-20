require 'active_record'

class ChangeColumnsToText < ActiveRecord::Migration[5.0]
  def change
    change_column :gifts, :link, :text
    change_column :gifts, :image_url, :text
  end
end 
