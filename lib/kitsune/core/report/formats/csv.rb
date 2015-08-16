require 'csv'


<<<<<<< HEAD
<<<<<<< HEAD
=======
# The name of the class is equivalent to the name of the file
# without the extension
>>>>>>> 4996af7203b0f90794bd66a9ea63aad0b12cfed3
=======
# The name of the class is equivalent to the name of the file
# without the extension
>>>>>>> 4996af7203b0f90794bd66a9ea63aad0b12cfed3
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
