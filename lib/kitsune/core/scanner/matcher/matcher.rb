require 'kitsune/database/database'
require_relative './threshold/threshold'



module Match
  class Manager


    attr_accessor :checksums_to_match


    def initialize(database: database, threshold: threshold, options: {})
      @options = options
      @threshold = Threshold::Manager.new(threshold)
      @database = Kitsune::Database.new(database)
    end


    #=> Public Function <=
    def match_webapp(webapp)
      dataset = @database.database[
        "SELECT
           files.webapp_name,
           files.webapp_version,
           count.total_count,
           COUNT(*) AS matched_count
         FROM
           files
         INNER JOIN
           count
         ON
           files.webapp_version = count.webapp_version
         WHERE
           files.webapp_name = ? AND (files.file_checksum IN ?)
         GROUP BY
           count.webapp_name, count.webapp_version
         HAVING
           matched_count >= (count.total_count * ?)
         ORDER BY
           files.webapp_name, matched_count DESC
         ", webapp, @checksums_to_match.values, @threshold.threshold
      ]

      dataset.map do |d|
        d.merge!(
          :probability => probability(d[:total_count], d[:matched_count]),
          :path => match_path(d)
        )
      end

    end


    def match_version(version)
      dataset = @database.database[
        "SELECT
           files.webapp_name,
           files.webapp_version,
           count.total_count,
           COUNT(*) AS matched_count
         FROM
           files
         INNER JOIN
           count
         ON
           files.webapp_version = count.webapp_version
         WHERE
          files.webapp_version = ? AND (files.file_checksum IN ?)
         GROUP BY
           count.webapp_name, count.webapp_version
         HAVING
           matched_count >= (count.total_count * ?)
         ORDER BY
           files.webapp_name, matched_count DESC
         ", version, @checksums_to_match.values, @threshold.threshold
      ]

      dataset.map do |d|
        d.merge!(
          :probability => probability(d[:total_count], d[:matched_count]),
          :path => match_path(d)
        )
      end

    end


    def match_both(webapp, version)
      dataset = @database.database[
        "SELECT
           files.webapp_name,
           files.webapp_version,
           count.total_count,
           COUNT(*) AS matched_count
         FROM
           files
         INNER JOIN
           count
         ON
           files.webapp_version = count.webapp_version
         WHERE
           files.webapp_name = ? AND files.webapp_version = ? (files.file_checksum IN ?)
         GROUP BY
           count.webapp_name, count.webapp_version
         HAVING
           matched_count >= (count.total_count * ?)
         ORDER BY
           files.webapp_name, matched_count DESC
         ", webapp, version, @checksums_to_match.values, @threshold.threshold
      ]

      dataset.map do |d|
        d.merge!(
          :probability => probability(d[:total_count], d[:matched_count]),
          :path => match_path(d)
        )
      end

    end


    def match_all
      dataset = @database.database[
        "SELECT DISTINCT
           files.webapp_name,
           files.webapp_version,
           count.total_count,
           COUNT(*) AS matched_count
         FROM
           files
         INNER JOIN
           count
         ON
           files.webapp_version = count.webapp_version
         WHERE
           (files.file_checksum IN ?)
         GROUP BY
           count.webapp_version, count.webapp_name
         HAVING
           matched_count >= (count.total_count * ?)
         ORDER BY
           files.webapp_name, matched_count DESC
         ", @checksums_to_match.values, @threshold.threshold
      ]

      dataset.map do |d|
        d.merge!(
          :probability => probability(d[:total_count], d[:matched_count]),
          :path => match_path(d)
        )
      end
    end


    #=> Helper Functions <=

    def match_path(dataset)
      matched =
        @database.database[
          "SELECT DISTINCT
             file_checksum
           FROM
             files
           WHERE
             (file_checksum IN ?) AND
             webapp_name = ?      AND
             webapp_version = ?
          ", @checksums_to_match.values,
             dataset[:webapp_name],
             dataset[:webapp_version]
        ]


      paths = []
      matched.map(&:values).take(5).each do |x|
        paths << @checksums_to_match.rassoc(*x)[0]
      end

      return shortest_common_path(paths)
    end


    # probability forumla
    # => param [t]
    #  total number of files in the set
    # => param [m]
    #  number of matching files in the set
    def probability(t, m)
      ([t, m].min.to_f / [t, m].max.to_f).round(2)
    end


    def shortest_common_path(dirs)
      dir1, dir2 = dirs.minmax.map { |d| d.split("/") }
      dir1.zip(dir2).keep_if { |d1, d2| d1 == d2 }.map(&:first).join("/")
    end

  end
end
