
require 'colorize'


module Exceptions
  module Manager

    # => Raised when the given threshold is not between 0.0 and 1.0
    InvalidThresholdError = Class.new(RuntimeError)

    # => Raised when the path to the given database
    DatabaseNotFoundError = Class.new(RuntimeError)

    # => Raised when there are insefficient privileges to read a file
    InvalidFormatError    = Class.new(RuntimeError)

    # => Raised when there are insefficient privileges to read a file
    PermissionDeniedError = Class.new(Errno::EACCES)


    def assert(error, &block)
      raise error unless yield
    end


    def abort_with_info(message)
      abort "[!]".colorize(:red) + " #{message}"
    end

  end
end
