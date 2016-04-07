configure :development do
  set :database_url, 'sqlite://db/dev.db'
end

configure :test do
  set :database_url, 'sqlite://db/test.db'
end
