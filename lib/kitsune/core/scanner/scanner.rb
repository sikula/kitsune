
require 'find'
require 'pathname'

require 'kitsune/exception/exception'
require 'kitsune/checksum/checksum'
require 'kitsune/report/report'

require_relative './matcher/matcher'


module Kitsune
  class Scanner

    include Exceptions


    attr_reader :results


    def initialize(options = {})
      @options = options
    end


    def run_scan
      matcher = Match::Manager.new(
        database:  @options["--database"],
        threshold: @options["--probability"],
        options: options
      )
      matcher.checksums_to_match = collect_checksums

      @results =
        if @options["--webapp"] && !@options["--app-version"]
          matcher.match_webapp(@options["--webapp"])
        elsif @options["--app-version"] && !@options["--webapp"]
          matcher.match_version(@options["--app-version"])
        elsif @options["--webapp"] && @options["--app-version"]
          matcher.match_both(@options["--webapp"], @options["--app-version"])
        elsif !@options["--webapp"] && !@options["--app-version"]
          matcher.match_all
        end
    end


    def collect_checksums
      checksums = {}
      collect_files(*@options["--path"]) do |file|
        checksums[file] = Kitsune::Checksum.checksum_file(file)
      end
      return checksums
    end


    #=> Helper Functions <=
    def collect_files(directory)
      Find.find(directory).each do |entry|
        next unless File.file?(entry)
        yield(entry)
      end

    rescue PermissionDeniedError => e
      abort_with_info(e.message)
    end


  end
end
