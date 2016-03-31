require 'sinatra'
require 'json'
require 'base64'

# Security Credential Sharing Web Service
class ShareCredentials < Sinatra::Base

  def credentials_file(id)
    credential_file = File.read('public/'+id+'.txt')
  end

  get '/?' do
    'Share Credentials web app is up and running at /api/v1'
  end

  get '/api/v1' do
    # TODO: show all routes as json doc
  end

  get '/api/v1/credentials/?' do
    content_type 'application/json'

    credentials_list = Dir.glob('public/*.txt').map do |filename|
      filename.match(/public\/(.*)\.txt/)[1]
    end

    {credentials: credentials_list }.to_json
  end

  get '/api/v1/credentials/:id.txt' do
    content_type 'text/plain'

    begin
      credentials_file(params[:id])
    rescue => e
      status 404
    end
  end

  get '/api/v1/credentials/:id.json' do
    content_type 'application/json'

    begin
      creds = Base64.strict_encode64(credentials_file(params[:id]))
      { credentials: creds }.to_json
    rescue => e
      status 404
      e.inspect
    end
  end

  post '/api/v1/credentials/new' do
    # TODO: let users create new credential files
  end
end
