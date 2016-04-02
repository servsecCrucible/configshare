# ConfigShare API

API to store and retrieve configuration files

## Routes

- `api/v1/configurations`: returns a json of all confiugration IDs
- `api/v1/configurations/[ID].json`: returns a json of all information about a configuration with given ID
- `api/v1/configurations/[ID]/document`: returns a text/plain document with a configuration document for given ID

## Install

Install this API by cloning the *relevant branch* and installing required gems:

    $ bundle install

## Execute

Run this API by using:

    $ rackup
