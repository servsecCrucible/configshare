require 'sinatra'
require 'json'
require 'base64'

# Configuration Sharing Web Service
class ShareConfigurationsApp < Sinatra::Base
  STORE_DIR = 'public/'.freeze

  def configurations(id)
    File.read(STORE_DIR + id + '.txt')
  end

  before do
    Dir.mkdir(STORE_DIR) unless Dir.exist? STORE_DIR
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
    content_type 'application/json'

    begin
      request_params = JSON.parse request.body.read
      new_configurations = Base64.strict_decode64(request_params['config_data'])
      new_id = Base64.urlsafe_encode64(Digest::SHA256.digest(Time.now.to_s))
      filename = STORE_DIR + new_id[0..9] + '.txt'

      File.open(filename, 'w') do |file|
        puts "NEW CONFIG FILE CREATED: #{filename}"
        file.write(new_configurations)
      end

      redirect '/api/v1/configurations/' + new_id + '.txt'
    rescue => e
      status 400
      puts e.inspect
    end
  end
end
