require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

# The below command stops the SQL queries from showing up on the terminal
ActiveRecord::Base.logger = nil