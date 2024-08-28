require 'bundler/setup'
require 'visibilize'

require 'sqlite3'
require 'active_record'

require 'models/user'
require 'models/animal'
require 'models/car'
require 'models/building'
require 'models/keyboard'
require 'models/computer'
require 'models/book'
require 'models/furniture'

def setup_database
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

  return if ActiveRecord::Base.connection.tables.any?

  # Read and execute the schema.sql file
  schema_file = File.join(File.dirname(__FILE__), 'db', 'schema.sql')
  sql_statements = File.read(schema_file)

  # Split the SQL statements and execute them individually
  sql_statements.split(';').each do |statement|
    statement.strip!
    ActiveRecord::Base.connection.execute(statement) if statement.present?
  end
  puts 'Database schema created.'
end

UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    setup_database
  end
end
