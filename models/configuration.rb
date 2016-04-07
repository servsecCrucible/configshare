require 'json'

# Holds a full configuration file's information
class Configuration < Sequel::Model
  many_to_one :projects

  def to_json(options = {})
    JSON({  type: 'configuration',
            id: id,
            data: {
              name: filename,
              description: description,
              document: document
            }
          },
         options)
  end
end

# TODO: implement a more complex primary key?
# def new_id
#   Base64.urlsafe_encode64(Digest::SHA256.digest(Time.now.to_s))[0..9]
# end
