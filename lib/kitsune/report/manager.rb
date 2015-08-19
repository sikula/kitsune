
require 'find'
require 'json'

require 'kitsune/exception/manager'


module Kitsune
  class Report

    include Exceptions


    def initialize(results, options = {})
      @results = results
      @options = options
    end


    # Public: Calles the "format" method from a format class.
    #
    #
    # Examples
    #
    #   report = Kitsune::Report.new({}, :format => :json)
    #   report.format
    #   # =>  {}
    #
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

    # Private: Collects the format name and path of format file and stores it
    #          in a hash.
    #
    #
    # Examples
    #
    #   format, path = _retrieve_format.to_a.flatten
    #   # => ["csv", "/formats/json.rb"]
    #
    def _retrieve_format
      paths = Dir[__dir__ + "/formats/*.rb"]
      paths.each_with_object({}) do |file, hash|
        format = file.split("/").last.split(".").first
        hash[format] = file if format.eql?(@options[:format])
      end
    end

  end
end
