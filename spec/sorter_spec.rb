require 'rails_helper'

describe StringParser do
  class DummyClass
    include StringParser
  end

  it "parses tab delimited string" do

    tab_string = "Led Zeppelin\tlameness\nplatypuses\tlikely things\nLed Zeppelin\tMaroon 5\nBoulder, CO\tHouston\n\n\nthis \t that\n"

    this = [["Led Zeppelin", "lameness"], ["platypuses", "likely things"], ["Led Zeppelin", "Maroon 5"], ["Boulder, CO", "Houston"], ["this ", " that"]]

    expect(DummyClass.new.parse_tabs(tab_string)).to eq(this)
  end

  it "parses sort options string" do

    opts_str1 = "fkv"
    order_arr1 = ["f", "k", "v"]

    opts_str2 = "f"
    order_arr2 = ["f"]

    opts_str3 = "bliggityBlah!"
    order_arr3 = []

    opts_str4 = "fwk"
    order_arr4 = ["f", "k"]

    opts_str5 = "vvvvv"
    order_arr5 = ["v"]


    expect(DummyClass.new.parse_opts(opts_str1)).to eq(order_arr1)
    expect(DummyClass.new.parse_opts(opts_str2)).to eq(order_arr2)
    expect(DummyClass.new.parse_opts(opts_str3)).to eq(order_arr3)
    expect(DummyClass.new.parse_opts(opts_str4)).to eq(order_arr4)
    expect(DummyClass.new.parse_opts(opts_str5)).to eq(order_arr5)
  end

end

describe Sorter do

  it "sorts array of hashes based on input string looking for fkv" do
    arr_to_sort = [{"filename" => "queens.txt", "key" => "LostBoyz", "value" => "Freeky Tah"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "GZA"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "Ghostface Killah"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "Inspectah Deck"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "Masta Killah"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "Method Man"},
                   {"filename" => "queens.txt", "key" => "LostBoyz", "value" => "MrCheeks"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "ODB"},
                   {"filename" => "queens.txt", "key" => "LostBoyz", "value" => "Pretty Lou"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "RZA"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "Raekwon"},
                   {"filename" => "queens.txt", "key" => "LostBoyz", "value" => "Spigg Nice"},
                   {"filename" => "staten.txt", "key" => "Wutang", "value" => "U-God"}]

    order_str1 = "fwvwa" #fvk

    correct_order1 = [{"filename" => "queens.txt", "key" => "LostBoyz", "value" => "Freeky Tah"},
                      {"filename" => "queens.txt", "key" => "LostBoyz", "value" => "MrCheeks"},
                      {"filename" => "queens.txt", "key" => "LostBoyz", "value" => "Pretty Lou"},
                      {"filename" => "queens.txt", "key" => "LostBoyz", "value" => "Spigg Nice"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "GZA"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "Ghostface Killah"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "Inspectah Deck"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "Masta Killah"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "Method Man"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "ODB"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "RZA"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "Raekwon"},
                      {"filename" => "staten.txt", "key" => "Wutang", "value" => "U-God"}]


    expect(Sorter.new(arr_to_sort, order_str1).sort).to eq(correct_order1)

  end
end