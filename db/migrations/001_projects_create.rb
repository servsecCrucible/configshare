require 'sequel'

Sequel.migration do
  change do
    create_table(:projects) do
      primary_key :id
      String :name, unique: true, null: false
      String :repo_url, unique: true
    end
  end
end
