require 'json'
require 'sequel'

# Holds a Project's information
class Project < Sequel::Model
  one_to_many :configurations

  def to_json(options = {})
    JSON({  type: 'project',
            id: id,
            attributes: {
              name: name,
              repo_url: repo_url
            }
          },
         options)
  end
end
