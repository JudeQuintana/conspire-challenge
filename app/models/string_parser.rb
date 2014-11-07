require 'csv'

module StringParser

  def parse_tabs(tab_string)
    CSV.parse(tab_string, {:col_sep => "\t", :skip_blanks => true})
  end

  def parse_opts(opts_string)
    opts_string.nil? ? [] : opts_string[0..2].split(//).uniq.select { |char| char =~ /[fkv]/ }
  end
end