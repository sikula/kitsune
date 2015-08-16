require 'text-table'


table = Module.new do
  def self.format(input)
    _table = Text::Table.new
    _table.head =
      [
        "Webapp Name",
        "Version",
        "Probability",
        "Total Count",
        "Matched Count",
        "Approximate Webapp Path"
      ]
    input.each do |res|
      _table.rows << [
        {:value => res[:webapp_name],   :align => :center},
        res[:webapp_version],
        {:value => res[:probability],   :align => :center},
        {:value => res[:total_count],   :align => :center},
        {:value => res[:matched_count], :align => :center},
        res[:path]
      ]
    end
    _table.to_s
  end
end
