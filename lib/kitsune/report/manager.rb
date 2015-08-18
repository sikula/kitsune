
require 'find'
require 'json'

require 'kitsune/exception/manager'


module Report
  class Manager

    include Exceptions


    def initialize(results, options = {})
      @results = results
      @options = options
    end


    # Calls the "format" method from the class associated with the format
    def format
      format, path = _retrieve_format.to_a.flatten
      assert(InvalidFormatError) { format.eql?(@options[:format]) }
    rescue InvalidFormatError => e
      abort_with_info(
        "#{e.message}: Invalid Output Format => #{@options[:format]}"
      )
    else # => execute only if NO errors were raised
      return eval(File.read(path)).send(:format, @results)
    end


  private

    # Creates a hash containing the format name (file_name without extension)
    # and path to the class associated with that format
    def _construct_format_hash(paths)
      paths.each_with_object({}) do |file, hash|
        format = file.split("/").last.split(".").first
        hash[format] = file if format.eql?(@options[:format])
      end
    end


    # Gets the format name and path of the format class
    # (e.g  --format=json )
    #   => { "json" => "./formats/json.rb" }
    def _retrieve_format
      _construct_format_hash(Dir[__dir__ + "/formats/*.rb"])
    end


  end
end
