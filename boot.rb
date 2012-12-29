require 'rubygems'
require 'bundler'

Bundler.require
require 'open-uri'

Dir[File.dirname(__FILE__) + "/app/**/*.rb"].each do |file|
  require file
end
