# load the config file
require './utils/config'

# set up the database connection
require 'utils/database'

# get sinatra and the app
require 'sinatra'
require 'app'

# run it
run Sinatra::Application

