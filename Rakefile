require 'rake/testtask'
require './app'

task :default => [:spec]

namespace :db do
  require 'sequel'
  Sequel.extension :migration

  desc 'Run migrations'
  task :migrate do |_, args|
    puts "Migration for environment: #{ENV['RACK_ENV']}"
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(DB, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(DB, 'db/migrations')
    end
  end

  desc 'Perform migration reset (full rollback and migration)'
  task :reset do
    Sequel::Migrator.run(DB, 'db/migrations', target: 0)
    Sequel::Migrator.run(DB, 'db/migrations')
  end
end

desc 'Run all the tests'
Rake::TestTask.new(name=:spec) do |t|
  t.pattern = 'specs/*_spec.rb'
end
