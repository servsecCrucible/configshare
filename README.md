# ConfigShare API

API to store and retrieve configuration files

## Routes

### Application Routes
- GET `/`: root route

### Project Routes
- GET `api/v1/projects/`: returns a json list of all projects
- GET `api/v1/projects/[ID]`: returns a json of all information about a project
- POST `api/v1/projects/`: creates a new project

### Configuration Routes
- GET `api/v1/projects/[PROJECT_ID]/configurations/`: returns a json of all configurations for a project
- GET `api/v1/projects/[PROJECT_ID]/configurations/[ID].json`: returns a json of all information about a configuration
- GET `api/v1/projects/[PROJECT_ID]/configurations/[ID]/document`: returns a text/plain document with a configuration document
- POST `api/v1/projects/[PROJECT_ID]/configurations/`: creates a new configuration for a project

## Install

Install this API by cloning the *relevant branch* and installing required gems:

    $ bundle install

## Execute

Run this API by using:

    $ rackup
