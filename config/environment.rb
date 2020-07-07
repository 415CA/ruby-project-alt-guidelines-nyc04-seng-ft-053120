require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

# Stops SQL queries from showing up in terminal 
ActiveRecord::Base.logger = nil
