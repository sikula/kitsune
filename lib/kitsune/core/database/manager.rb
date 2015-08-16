require 'sequel'

require_relative '../exception/manager'

module Database
  class Manager

    include Exceptions::Manager


    attr_reader :database

    def initialize(database)
      @database = load_database(database || default_database)
    end


    def default_database
      File.expand_path("../../../../../app/webapps.sqlite", __FILE__)
    end


    def load_table(table_name)
      @database[table_name]
    end


    def load_database(database)
      assert(DatabaseNotFoundError) { File.exists?(database) }
      return Sequel.sqlite(database)
    rescue DatabaseNotFoundError => e
      abort_with_info "#{e.message}: Cannot Load Database => #{database}"
    end


  end
end
