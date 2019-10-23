require 'active_record'
require 'models/user'

class AddEventsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :slug
      t.string :name
    end

    Event.reset_column_information
    Event.create(slug: 'lemburgchristmas2018', name: 'Lemburg Christmas 2018')
    Event.create(slug: 'lemburgchristmas2019', name: 'Lemburg Christmas 2019')

    add_column :gifts, :event_id, :integer, default: 1
  end
end
