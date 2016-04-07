require 'sinatra'
require 'json'
require 'base64'
require_relative 'config/environments'
require_relative 'models/init'

# Configuration Sharing Web Service
class ShareConfigurationsAPI < Sinatra::Base
  get '/?' do
    'ConfigShare web service is up and running at /api/v1'
  end

  get '/api/v1/?' do
    # TODO: show all routes as json with links
  end

  get '/api/v1/projects/?' do
    content_type 'application/json'

    JSON.pretty_generate(data: Project.all)
  end

  get '/api/v1/projects/:project_id/configurations/?' do
    content_type 'application/json'

    project = Project[params[:project_id]]

    JSON.pretty_generate(data: project.configurations)
  end

  get '/api/v1/configurations/:id/document' do
    content_type 'text/plain'

    begin
      Base64.strict_decode64 Configuration.find(params[:id]).document
    rescue => e
      status 404
      e.inspect
    end
  end

  get '/api/v1/configurations/:id.json' do
    content_type 'application/json'

    begin
      { configuration: Configuration.find(params[:id]) }.to_json
    rescue => e
      status 404
      logger.info "FAILED to GET configuration: #{e.inspect}"
    end
  end

  post '/api/v1/configurations/?' do
    content_type 'application/json'

    begin
      new_data = JSON.parse(request.body.read)
      new_config = Configuration.new(new_data)
      if new_config.save
        logger.info "NEW CONFIGURATION STORED: #{new_config.id}"
      else
        halt 400, "Could not store config: #{new_config}"
      end

      redirect '/api/v1/configurations/' + new_config.id + '.json'
    rescue => e
      status 400
      logger.info "FAILED to create new config: #{e.inspect}"
    end
  end
end
