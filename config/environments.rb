configure :development do
  set :database_url, 'sqlite://db/dev.db'
  require 'hirb'
  Hirb.enable
end

configure :test do
  set :database_url, 'sqlite://db/test.db'
end

configure do
  enable :logging
end
