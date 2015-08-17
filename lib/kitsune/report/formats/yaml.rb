require 'yaml'


module ::YAML
  def self.format(input)
    input.to_yaml if input.respond_to?(:to_yaml)
  end
end
