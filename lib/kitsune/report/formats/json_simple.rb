=begin

  KITSUNE

  Author  : Peter Vicherek
=end

require 'json'


json_simple = Module.new do
  def self.format(input)
    input.to_json input.respond_to?(:to_json)
  end
end
