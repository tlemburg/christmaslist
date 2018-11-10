ROOT = File.expand_path(File.dirname(__FILE__)) << '/..'
$LOAD_PATH.unshift(ROOT)

require 'json'

config = Hash.new
Dir.glob("#{ROOT}/config/*.json") { |file| 
  config.merge!(JSON.parse(File.read(file)))
}

config["db"]["host"] = ENV['DB_HOST'] if ENV['DB_HOST']
config["db"]["username"] = ENV['DB_USER'] if ENV['DB_USER']
config["db"]["password"] = ENV['DB_PASS'] if ENV['DB_PASS']
config["db"]["database"] = ENV['DB_NAME'] if ENV['DB_NAME']


CONFIG = config
