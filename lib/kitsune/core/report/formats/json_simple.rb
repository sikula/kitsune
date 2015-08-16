require 'json'


module JSON_Simple
  def self.format(input)
    input.to_json input.respond_to?(:to_json)
  end
end
