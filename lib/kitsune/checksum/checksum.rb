require 'xxhash'


module Kitsune
  module Checksum

    # Public: Seed value XXhash uses to generate checksum.
    XXHASH_SEED_VALUE = 4645769952020671

    # Public: The number of bytes from a stream to read at a time.
    STREAM_CHUNK_SIZE = 4096


    # Public: Calculates the checksum of a given file.
    #
    # file - path of file to checksum
    #
    # Examples
    #
    #   Checksum::Managerr.checksum_file("/some/file/to/sum")
    #   # =>  87B69D578AEE7562
    #
    def self.checksum_file(file)
      File.open(file, "rb") do |stream|
        XXhash.xxh64_stream(stream, XXHASH_SEED_VALUE, STREAM_CHUNK_SIZE).to_s(16).upcase
      end
    end


    # Public: Calculates the checksum of a line.
    #
    # line - line to be checksummed
    #
    # Examples
    #
    #   File.readlines(file_name).each_with_index do |line, index|
    #     checksum = Checksum::Manager.checksum_line(line)
    #   end
    #   # => [87B69D578AEE7562, 87B69D578AEE7562, 87B69D578AEE7562]
    #
    def self.checksum_line(line)
      XXhash.xxh64(line, XXHASH_SEED_VALUE).to_s(16).upcase
    end
    
  end
end
