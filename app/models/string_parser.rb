require 'csv'

module StringParser

  def parse_tabs(tab_string)#parses tab delimited string, skipping empty lines
    CSV.parse(tab_string, {:col_sep => "\t", :skip_blanks => true})
  end

  def parse_opts(opts_string) #only allows f,k or v chars if string is not nil
    opts_string.nil? ? [] : opts_string.split(//).uniq.select { |char| char =~ /[fkv]/ }
  end
end