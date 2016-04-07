require 'sequel'
DB = Sequel.connect(settings.database_url)

require_relative './project'
require_relative './configuration'
