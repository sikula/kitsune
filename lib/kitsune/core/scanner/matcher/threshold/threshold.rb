require 'colorize'
require 'kitsune/exception/exception'

module Threshold
  class Manager

    include Exceptions

    # Public: Returns the threshold value
    attr_reader :threshold


    def initialize(threshold)
      @threshold = threshold.nil? ? default_threshold_value : Float(threshold)
      check_threshold
    end


    # Public: Returns the default threshold value
    #
    # Examples
    #
    #   puts default_threshold_value
    #   # => 0.7
    #
    def default_threshold_value
      0.7
    end


    # Public: Calculates the minimum ammount of files to match
    #
    # Examples
    #
    #   puts min_threshold_value(100)
    #   # => 70
    #
    def min_threshold_value(sample_size)
      Integer(sample_size * @threshold)
    end


    # Private: Checks that the threshold value is of type Float
    #
    def float_value?
      assert(InvalidThresholdError) { @threshold.is_a?(Float) }
    rescue InvalidThresholdError => e
      abort_with_info "#{e.message}: Threshold value must be a Floating Point value!"
    end


    # Private: Checks that the threshold value is less than or equal to 1.0
    #
    def below_max?
      assert(InvalidThresholdError) { @threshold <= 1.0 }
    rescue InvalidThresholdError => e
      abort_with_info "#{e.message}: Threshold value cannot be greater than 1.0!"
    end


    # Private: Checks that threshold value is greater than or equal to 0.0
    #
    def above_min?
      assert(InvalidThresholdError) { @threshold >= 0.0 }
    rescue InvalidThresholdError => e
      abort_with_info "#{e.message}: Threshold value cannot be less than 0.0!"
    end


    # Private: Checks thats the value given for the threshold is passess all tests
    #
    def check_threshold
      float_value?
      below_max?
      above_min?
    end

  end
end
