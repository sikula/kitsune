require 'json'


module ::JSON
  def self.format(input)
    JSON.pretty_generate(input) if input.respond_to?(:to_json)
  end
end
