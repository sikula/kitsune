require 'colorize'
require 'kitsune/exception/manager'

module Threshold
  class Manager

    include Exceptions::Manager


    attr_reader :threshold

    def initialize(threshold)
      @threshold = threshold.nil? ? default_threshold_value : Float(threshold)
      check_threshold
    end


    def default_threshold_value
      0.7
    end


    # Calculates the minimum ammount of files to match
    def min_threshold_value(sample_size)
      Integer(sample_size * @threshold)
    end


    #=> Helper Functions <=
    def float_value?
      assert(InvalidThresholdError) { @threshold.is_a?(Float) }
    rescue InvalidThresholdError => e
      abort_with_info "#{e.message}: Threshold value must be a Floating Point value!"
    end


    def below_max?
      assert(InvalidThresholdError) { @threshold <= 1.0 }
    rescue InvalidThresholdError => e
      abort_with_info "#{e.message}: Threshold value cannot be greater than 1.0!"
    end


    def above_min?
      assert(InvalidThresholdError) { @threshold >= 0.0 }
    rescue InvalidThresholdError => e
      abort_with_info "#{e.message}: Threshold value cannot be less than 0.0!"
    end


    def check_threshold
      float_value?
      below_max?
      above_min?
    end

  end
end
