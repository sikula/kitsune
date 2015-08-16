require 'erubis'

html = Module.new do
  def self.format(input)
    template =
      File.expand_path("../assets/templates/reporting/to_html_report.ktp")

    Erubis::Eruby.new(
      File.read(template), :pattern => "{% %}").result(:results => input)
  end
end
