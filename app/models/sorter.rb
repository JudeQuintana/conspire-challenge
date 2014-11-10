class Sorter
  include StringParser

  DEFAULT_ORDER = %w{filename key value}

  def initialize(arr, sort_opts)
    @arr = arr
    @sort_opts = parse_opts(sort_opts)
  end

  def sort
    order_arr = build_order_arr
    @arr.sort_by { |obj| [obj[order_arr[0]], obj[order_arr[1]], obj[order_arr[2]]] }
    #sorting array of objects(hashes) by their key values according to the order of the order array
  end

  private

  def build_order_arr
    order_arr = @sort_opts.map { |char| letter_to_word(char) }
    order_arr + (DEFAULT_ORDER - order_arr)
    #array subtraction gives me what is missing if order_arr = ["key","value"]
    #then DEFAULT_ORDER - order_arr gives me "filename"
    #then add that to my order_arr = ["key", "value", "filename"]
    #so on and so forth, if order_arr = ["value"] then array subtraction gives me ["filename","key"],
    #then add them together
    #if order_arr is an empty array (blank sort_options) then the array subtraction gives me the DEFAULT_ORDER
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