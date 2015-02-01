require 'bundler'
Bundler.setup

require 'initializer'
require 'single'

['../lib'].each do |path|
  dir = File.expand_path(path, __FILE__)
  $LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)
end

require 'configatron'
require 'mongo'
require 'mongos'
