
require 'colorize'


module Exceptions

  # Public: Raises an error when a specified probability is out of bounds.
  InvalidThresholdError = Class.new(RuntimeError)

  # Public: Raises an error when the specified database is non-existent.
  DatabaseNotFoundError = Class.new(RuntimeError)

  # Public: Raises an error when an invalid format is specified.
  InvalidFormatError    = Class.new(RuntimeError)

  # Public: Raises an error when there are insufficient privleges to read a file.
  PermissionDeniedError = Class.new(Errno::EACCES)


  # Public: Raises an error of a specified type unless a condition is met.
  #
  # error - error type
  # block - condition to evaluate
  #
  # Examples
  #
  #   Exceptions::Manager.assert { 5 + 1 = 6 }
  #   # => ''
  #
  def assert(error, &block)
    raise error unless yield
  end


  # Public: Exits the program with a formatted output.
  #
  # message - Message to be written on exit
  #
  # Examples
  #
  #   Exceptions::Manager.abort_with_info("Something Broke")
  #   # => "[!] Something Broke"
  #
  def abort_with_info(message)
    abort "[!]".colorize(:red) + " #{message}"
  end

end
