require 'rubygems'
ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'deploy'

run Deploy
