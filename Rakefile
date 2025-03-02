require 'rubygems'
require 'bundler/setup'

require 'sqlite3'
require 'active_record'
require 'yaml'

require './db/migrate/create_user_table'

namespace :db do

  desc 'Migrate the database'
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migration.migrate('db/migrate/')
    CreateUserTable.new.change
  end

  desc 'Create the database'
  task :create do

  end

  desc 'Drop the database'
  task :drop do

  end
end