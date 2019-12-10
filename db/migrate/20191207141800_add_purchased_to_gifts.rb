require 'active_record'

class AddPurchasedToGifts < ActiveRecord::Migration[5.0]
  def change
    add_column :gifts, :purchased, :boolean, default: false
  end
end
