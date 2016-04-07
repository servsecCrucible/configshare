require 'sequel'

Sequel.migration do
  change do
    create_table(:configurations) do
      primary_key :id
      foreign_key :project_id

      String :filename, null: false
      String :relative_path, null: false, default: './'
      String :description
      String :base64_document, null: false, default: ''

      unique [:project_id, :filename]
    end
  end
end
