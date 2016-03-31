require 'sinatra'
require 'json'
require 'base64'

# Configuration Sharing Web Service
class ShareConfigurationsApp < Sinatra::Base
  STORE_DIR = 'public/'.freeze

  def configurations(id)
    File.read(STORE_DIR + id + '.txt')
  end

  get '/?' do
    'ConfigShare web service is up and running at /api/v1'
  end

  get '/api/v1' do
    # TODO: show all routes as json with links
  end

  get '/api/v1/configurations/?' do
    content_type 'application/json'

    configurations_list = Dir.glob(STORE_DIR + '*.txt').map do |filename|
      filename.match(%r{public\/(.*)\.txt})[1]
    end

    { configuration_id: configurations_list }.to_json
  end

  get '/api/v1/configurations/:id.txt' do
    content_type 'text/plain'

    begin
      configurations(params[:id])
    rescue => e
      status 404
      e.inspect
    end
  end

  get '/api/v1/configurations/:id.json' do
    content_type 'application/json'

    begin
      configs = Base64.strict_encode64(configurations(params[:id]))
      { configurations: configs }.to_json
    rescue => e
      status 404
      e.inspect
    end
  end

  post '/api/v1/configurations/new' do
    # TODO: let users create new configuration files
  end
end
