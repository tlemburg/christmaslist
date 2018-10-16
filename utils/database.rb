require 'active_record'

ActiveRecord::Base.establish_connection({
    :adapter => 'mysql2',
    :host => CONFIG["db"]["host"],
    :username => CONFIG["db"]["username"],
    :password => CONFIG["db"]["password"],
    :database => CONFIG["db"]["database"]
})

