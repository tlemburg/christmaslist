require './utils/config'
require 'utils/database'

require 'active_record'

task :migrate do
  ActiveRecord::MigrationContext.new('db/migrate').migrate(ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
end

