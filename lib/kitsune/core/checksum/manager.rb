require 'xxhash'


module Checksum
  class Manager

    XXHASH_SEED_VALUE = 4645769952020671
    STREAM_CHUNK_SIZE = 4096


    def self.checksum_file(file)
      File.open(file, "rb") do |stream|
        XXhash.xxh64_stream(stream, XXHASH_SEED_VALUE, STREAM_CHUNK_SIZE).to_s(16).upcase
      end
    end


    def self.line_checksum(line)
      XXhash.xxh64(line, XXHASH_SEED_VALUE).to_s(16).upcase
    end


  end
end
