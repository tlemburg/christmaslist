ROOT = File.expand_path(File.dirname(__FILE__)) << '/..'
$LOAD_PATH.unshift(ROOT)

require 'json'

config = Hash.new
Dir.glob("#{ROOT}/config/*.json") { |file| 
    config.merge!(JSON.parse(File.read(file)))
}

CONFIG = config
