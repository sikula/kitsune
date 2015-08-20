require 'sequel'

require 'kitsune/exception/exception'

module Kitsune
  class Database

    include Exceptions


    # Public: Returns the database being used
    attr_reader :database


    def initialize(database)
      @database = load_database(database || default_database)
    end


    # Public: Returns the path to the default database.
    #
    # Examples
    #
    #   puts default_database
    #   # => "/db/webapps.db"
    #
    def default_database
      File.expand_path("../../../../../app/webapps.sqlite", __FILE__)
    end


    # Public: Loads a table from the database.
    #
    # Examples
    #
    #   _TABLE = load_table(:table_name)
    #   # => ''
    #
    def load_table(table_name)
      @database[table_name]
    end


    # Public: Loads a database file.
    #
    # Examples
    #
    #   _DB = load_database("/db/webapps.db")
    #   # => ''
    #
    def load_database(database)
      assert(DatabaseNotFoundError) { File.exists?(database) }
      return Sequel.sqlite(database)
    rescue DatabaseNotFoundError => e
      abort_with_info "#{e.message}: Cannot Load Database => #{database}"
    end


  end
end
