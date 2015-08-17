#===============================================================================
# Author        =>  Peter Sikula
# Description   =>  Handles the parsing of command line options
# Notes         =>  Command line options are parsed using the 'docopt' library
#                   (http://docopt.org/).
#
#                   Options are defined with methods which (by convension) should
#                   have the same name as the option (e.g. if there is an option
#                    '--webapp' there should be an equivalent method 'webapp')
#===============================================================================

require 'docopt'


module CommandLine
  class Manager

    attr_reader :options

    @@commands = []

    def initialize
      __DOC__ = [banner_section, newline, options_section, *@@commands].join("\n")

      @options = Docopt::docopt(__DOC__)

      if @options["--help"] or ARGV.count < 1
        abort __DOC__
      end

    rescue Docopt::Exit
      puts __DOC__
      exit
    end



  private

    # => Helper Functions <=
    def self.register_option
      @@commands << yield
    end


    def self.define_opt(*args)
      return "    %-30s  %s" % [*args]
    end


    def banner_section
      [
        "Usage:",
        "  kitsune --path=path [options]",
        "  kitsune --help",
      ].join("\n")
    end


    def newline
      ""
    end


    def options_section
      return "Options:"
    end


    # => Methods Relatings To Command Line Options <=
    def self.database
      desc = %Q[
        Specify the database kitsune should match against]
      return define_opt("-d, --database=database", desc)
    end ; self.register_option { database }


    def self.format
      # desc = %Q[
      #   Specify the output format (xml, html, json, json-simple, csv).]
      desc = %Q[
        Specify the output format (csv, json, json-simple, yaml).]
      return define_opt("-f, --format=format", desc)
    end ; self.register_option { format }


    def self.help
      desc = %Q[
        Print this help message]
      return define_opt("-h, --help", desc)
    end ; self.register_option { help }


    # def self.mode
    #   desc = %Q[
    #     Specify the mode of the scanner (--mode=line, --mode=file).]
    #   return define_opt("-m, --mode=mode", desc)
    # end ; self.register_option { mode }


    def self.output
      desc = %Q[
        Specify the name of the output file.]
      return define_opt("-o, --output=file", desc)
    end ; self.register_option { output }


    # def self.serve
    #   desc = %Q[
    #     Starts a minimal HTTP server which serves the runtime report.]
    #   return define_opt("-S, --serve", desc)
    # end ; self.register_option { serve }


    def self.path
      desc = %Q[
        Specify the path where to start scanning from.]
      return define_opt("-p, --path=path", desc)
    end ; self.register_option { path }


    def self.probability
      desc = %Q[
        Show results greater than or equal to the given probability.
        The probability must be floating point number between 0.0 and 1.0]
      return define_opt("-P, --probability=probability", desc)
    end ; self.register_option {  probability }


    def self.webapp
      desc = %Q[
        Specify a particular webapp to match against.]
      return define_opt("-w, --webapp=name", desc)
    end ; self.register_option { webapp }


    def self.app_version
      desc = %Q[
        Specify a particular version of a webapp to match against (--webapp required).]
      return define_opt("-V, --app-version=version", desc)
    end ; self.register_option { app_version }

  end
end
