require_relative './spec_helper'

describe 'Testing Configuration resource routes' do
  before do
    Project.dataset.delete
    Configuration.dataset.delete

    req_header = { 'CONTENT_TYPE' => 'application/json' }
    req_body = { name: 'Demo Project' }.to_json
    post '/api/v1/projects/', req_body, req_header
    @existing_project = Project.first
  end

  describe 'Creating new configurations for projects' do
    it 'HAPPY: should add a new configuration for an existing project' do
      req_header = { 'CONTENT_TYPE' => 'application/json' }
      req_body = { filename: 'Demo Configuration' }.to_json
      post "/api/v1/projects/#{@existing_project.id}/configurations",
           req_body, req_header
      _(last_response.status).must_equal 201
      _(last_response.location).must_match(%r{http://})
    end

    it 'SAD: should not add a configuration for non-existant project' do
      req_header = { 'CONTENT_TYPE' => 'application/json' }
      req_body = { filename: 'Demo Configuration' }.to_json
      post "/api/v1/projects/#{invalid_id(Project)}/configurations",
           req_body, req_header
      _(last_response.status).must_equal 400
      _(last_response.location).must_be_nil
    end

    it 'SAD: should catch duplicate config files within a project' do
      req_header = { 'CONTENT_TYPE' => 'application/json' }
      req_body = { filename: 'Demo Configuration' }.to_json
      url = "/api/v1/projects/#{@existing_project.id}/configurations"
      post url, req_body, req_header
      post url, req_body, req_header
      _(last_response.status).must_equal 400
      _(last_response.location).must_be_nil
    end
  end
end
