require 'csv'


# The name of the class is equivalent to the name of the file
# without the extension
csv = Module.new do
  def self.format(input)
    CSV.generate do |csv|
      csv << [
        "webapp name",
        "webapp version",
        "total files",
        "matched files",
        "probability",
        "path"
      ]

      input.each { |i| csv << i.values }

    end
  end
end
