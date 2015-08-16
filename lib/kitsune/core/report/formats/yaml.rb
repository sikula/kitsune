require 'yaml'


yaml = Module.new do
  def self.format(input)
    input.to_yaml if input.respond_to?(:to_yaml)
  end
end
