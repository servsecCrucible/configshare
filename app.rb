require 'sinatra'
require 'json'
require 'base64'
require_relative 'config/environments'
require_relative 'models/init'

# Configuration Sharing Web Service
class ShareConfigurationsAPI < Sinatra::Base
  before do
    host_url = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    @request_url = URI.join(host_url, request.path.to_s)
  end

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

  get '/api/v1/projects/:id/configurations/?' do
    content_type 'application/json'

    project = Project[params[:id]]

    JSON.pretty_generate(data: project.configurations)
  end

  get '/api/v1/projects/:project_id/configurations/:id/?' do
    content_type 'application/json'

    begin
      doc_url = URI.join(@request_url.to_s + '/', 'document')
      configuration = Configuration
                      .where(project_id: params[:project_id], id: params[:id])
                      .first
      JSON.pretty_generate(data: {
                             configuration: configuration,
                             links: { document: doc_url }
                           })
    rescue => e
      status 404
      logger.info "FAILED to GET configuration: #{e.inspect}"
      e.inspect
    end
  end

  get '/api/v1/projects/:project_id/configurations/:id/document' do
    content_type 'text/plain'

    begin
      Configuration
        .where(project_id: params[:project_id], id: params[:id])
        .first
        .document
    rescue => e
      status 404
      e.inspect
    end
  end

  post '/api/v1/projects/:project_id/configurations/?' do
    content_type 'application/json'

    begin
      new_data = JSON.parse(request.body.read)
      project = Project[params[:project_id]]
      saved_config = project.add_configuration(new_data)
    rescue => e
      logger.info "FAILED to create new config: #{e.inspect}"
      halt 400
    end

    redirect URI.join(@request_url.to_s + '/' + saved_config.id.to_s)
  end
end
