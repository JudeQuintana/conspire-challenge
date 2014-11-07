class Sorter
  include StringParser

  DEFAULT_ORDER = ["filename", "key", "value"]

  def initialize(arr, sort_opts)
    @arr = arr
    @sort_opts = parse_opts(sort_opts)
  end

  def sort
    order_arr = build_order_arr
    @arr.sort_by { |obj| [obj[order_arr[0]], obj[order_arr[1]], obj[order_arr[2]]] }
  end

  private

  def build_order_arr
    order_arr = @sort_opts.map { |char| letter_to_word(char) }
    order_arr + (DEFAULT_ORDER - order_arr)
  end

  def letter_to_word(letter)
    case letter
      when "k"
        "key"
      when "v"
        "value"
      else
        "filename"
    end
  end
end