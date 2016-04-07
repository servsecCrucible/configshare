ENV['RACK_ENV'] = 'test'

require 'sequel'
require 'minitest/autorun'
require 'rack/test'
require_relative '../app'

include Rack::Test::Methods

def app
  ShareConfigurationsAPI
end
