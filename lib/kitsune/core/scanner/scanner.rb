
require 'find'
require 'pathname'

require 'kitsune/exception/manager'
require 'kitsune/checksum/manager'
require 'kitsune/report/manager'

require_relative './matcher'


module Kitsune
  class Scanner

    include Exceptions::Manager


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
        checksums[file] = Checksum::Manager.checksum_file(file)
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


    def shortest_common_prefix(dirs, separator = "/")
      dir1, dir2 = dirs.minmax.map { |d| d.split(separator) }
      dir1.zip(dir2).take_while { |d1, d2| d1 == d2 }.map(&:first).join(separator)
    end


  end
end
