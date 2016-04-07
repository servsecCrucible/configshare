require 'sequel'
DB = Sequel.connect(ENV['DATABASE_URL'])

require_relative './project'
require_relative './configuration'
