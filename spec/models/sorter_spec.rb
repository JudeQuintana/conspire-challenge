require 'rails_helper'

describe Sorter do

  it "privately converts letters to the associated word only for f,k or v. default to f" do

    expect(Sorter.new([], "").send(:letter_to_word, "f")).to eq("filename")
    expect(Sorter.new([], "").send(:letter_to_word, "k")).to eq("key")
    expect(Sorter.new([], "").send(:letter_to_word, "v")).to eq("value")
    expect(Sorter.new([], "").send(:letter_to_word, "a")).to eq("filename")
  end

  it "privately builds sort order array from the sort options string" do

    expect(Sorter.new([], "").send(:build_order_arr)).to eq(["filename", "key", "value"])
    expect(Sorter.new([], "f").send(:build_order_arr)).to eq(["filename", "key", "value"])
    expect(Sorter.new([], "k").send(:build_order_arr)).to eq(["key", "filename", "value"])
    expect(Sorter.new([], "v").send(:build_order_arr)).to eq(["value", "filename", "key"])
    expect(Sorter.new([], "kv").send(:build_order_arr)).to eq(["key", "value", "filename"])
    expect(Sorter.new([], "vk").send(:build_order_arr)).to eq(["value", "key", "filename"])
    expect(Sorter.new([], "vsvvsafasfk").send(:build_order_arr)).to eq(["value", "filename", "key"])
    expect(Sorter.new([], "ksasksfkaeqkval").send(:build_order_arr)).to eq(["key", "filename", "value"])
    expect(Sorter.new([], "fffkkvkkvv").send(:build_order_arr)).to eq(["filename", "key", "value"])
    expect(Sorter.new([], "bliggityBlah!").send(:build_order_arr)).to eq(["filename", "key", "value"])

  end

  it "sorts array of hashes based on input string looking for fkv" do
    arr_to_sort = [{"filename" => "claims_to_fame.txt", "key" => "Bakersfield", "value" => ""},
                   {"filename" => "claims_to_fame.txt", "key" => "Maroon 5", "value" => "lameness"},
                   {"filename" => "claims_to_fame.txt", "key" => "platypuses", "value" => "parts of lots of different animals"},
                   {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"},
                   {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "Paul McCartney"},
                   {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "John Lennon"},
                   {"filename" => "lead_singers.txt", "key" => "Explosions in the Sky", "value" => ""},
                   {"filename" => "lead_singers.txt", "key" => "Boyz 2 Men", "value" => "all of them"},
                   {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "lameness"},
                   {"filename" => "opposites.txt", "key" => "platypuses", "value" => "likely things"},
                   {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "Maroon 5"},
                   {"filename" => "opposites.txt", "key" => "Boulder, CO", "value" => "Houston"}]

    order_str1 = "f" #same as fkv

    correct_order1 = [{"filename" => "claims_to_fame.txt", "key" => "Bakersfield", "value" => ""},
                      {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"},
                      {"filename" => "claims_to_fame.txt", "key" => "Maroon 5", "value" => "lameness"},
                      {"filename" => "claims_to_fame.txt", "key" => "platypuses", "value" => "parts of lots of different animals"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "John Lennon"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "Paul McCartney"},
                      {"filename" => "lead_singers.txt", "key" => "Boyz 2 Men", "value" => "all of them"},
                      {"filename" => "lead_singers.txt", "key" => "Explosions in the Sky", "value" => ""},
                      {"filename" => "opposites.txt", "key" => "Boulder, CO", "value" => "Houston"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "Maroon 5"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "lameness"},
                      {"filename" => "opposites.txt", "key" => "platypuses", "value" => "likely things"}]

    expect(Sorter.new(arr_to_sort, order_str1).sort).to eq(correct_order1)

    order_str2 = "k" #same as kfv

    correct_order2 = [{"filename" => "claims_to_fame.txt", "key" => "Bakersfield", "value" => ""},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "John Lennon"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "Paul McCartney"},
                      {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"},
                      {"filename" => "opposites.txt", "key" => "Boulder, CO", "value" => "Houston"},
                      {"filename" => "lead_singers.txt", "key" => "Boyz 2 Men", "value" => "all of them"},
                      {"filename" => "lead_singers.txt", "key" => "Explosions in the Sky", "value" => ""},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "Maroon 5"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "lameness"},
                      {"filename" => "claims_to_fame.txt", "key" => "Maroon 5", "value" => "lameness"},
                      {"filename" => "claims_to_fame.txt", "key" => "platypuses", "value" => "parts of lots of different animals"},
                      {"filename" => "opposites.txt", "key" => "platypuses", "value" => "likely things"}]

    expect(Sorter.new(arr_to_sort, order_str2).sort).to eq(correct_order2)

    order_str3 = "v" #same as vfk

    correct_order3 = [{"filename" => "claims_to_fame.txt", "key" => "Bakersfield", "value" => ""},
                      {"filename" => "lead_singers.txt", "key" => "Explosions in the Sky", "value" => ""},
                      {"filename" => "opposites.txt", "key" => "Boulder, CO", "value" => "Houston"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "John Lennon"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "Maroon 5"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "Paul McCartney"},
                      {"filename" => "lead_singers.txt", "key" => "Boyz 2 Men", "value" => "all of them"},
                      {"filename" => "claims_to_fame.txt", "key" => "Maroon 5", "value" => "lameness"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "lameness"},
                      {"filename" => "opposites.txt", "key" => "platypuses", "value" => "likely things"},
                      {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"},
                      {"filename" => "claims_to_fame.txt", "key" => "platypuses", "value" => "parts of lots of different animals"}]

    expect(Sorter.new(arr_to_sort, order_str3).sort).to eq(correct_order3)


    order_str4 = "kv" #same as kvf

    correct_order4 = [{"filename" => "claims_to_fame.txt", "key" => "Bakersfield", "value" => ""},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "John Lennon"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "Paul McCartney"},
                      {"filename" => "opposites.txt", "key" => "Boulder, CO", "value" => "Houston"},
                      {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"},
                      {"filename" => "lead_singers.txt", "key" => "Boyz 2 Men", "value" => "all of them"},
                      {"filename" => "lead_singers.txt", "key" => "Explosions in the Sky", "value" => ""},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "Maroon 5"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "lameness"},
                      {"filename" => "claims_to_fame.txt", "key" => "Maroon 5", "value" => "lameness"},
                      {"filename" => "opposites.txt", "key" => "platypuses", "value" => "likely things"},
                      {"filename" => "claims_to_fame.txt", "key" => "platypuses", "value" => "parts of lots of different animals"}]

    expect(Sorter.new(arr_to_sort, order_str4).sort).to eq(correct_order4)


    order_str5 = "vk" #same as vkf

    correct_order5 = [{"filename" => "claims_to_fame.txt", "key" => "Bakersfield", "value" => ""},
                      {"filename" => "lead_singers.txt", "key" => "Explosions in the Sky", "value" => ""},
                      {"filename" => "opposites.txt", "key" => "Boulder, CO", "value" => "Houston"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "John Lennon"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "Maroon 5"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "Paul McCartney"},
                      {"filename" => "lead_singers.txt", "key" => "Boyz 2 Men", "value" => "all of them"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "lameness"},
                      {"filename" => "claims_to_fame.txt", "key" => "Maroon 5", "value" => "lameness"},
                      {"filename" => "opposites.txt", "key" => "platypuses", "value" => "likely things"},
                      {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"},
                      {"filename" => "claims_to_fame.txt", "key" => "platypuses", "value" => "parts of lots of different animals"}]

    expect(Sorter.new(arr_to_sort, order_str5).sort).to eq(correct_order5)

    order_str6 = "fv" #same as fvk

    correct_order6 = [{"filename" => "claims_to_fame.txt", "key" => "Bakersfield", "value" => ""},
                      {"filename" => "claims_to_fame.txt", "key" => "Maroon 5", "value" => "lameness"},
                      {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"},
                      {"filename" => "claims_to_fame.txt", "key" => "platypuses", "value" => "parts of lots of different animals"},
                      {"filename" => "lead_singers.txt", "key" => "Explosions in the Sky", "value" => ""},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "John Lennon"},
                      {"filename" => "lead_singers.txt", "key" => "Beatles", "value" => "Paul McCartney"},
                      {"filename" => "lead_singers.txt", "key" => "Boyz 2 Men", "value" => "all of them"},
                      {"filename" => "opposites.txt", "key" => "Boulder, CO", "value" => "Houston"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "Maroon 5"},
                      {"filename" => "opposites.txt", "key" => "Led Zeppelin", "value" => "lameness"},
                      {"filename" => "opposites.txt", "key" => "platypuses", "value" => "likely things"}]

    expect(Sorter.new(arr_to_sort, order_str6).sort).to eq(correct_order6)

    order_str7 = "fkv" #same as f

    expect(Sorter.new(arr_to_sort, order_str7).sort).to eq(correct_order1)

    order_str8= "ffasekffqirvvv" #same as fkv

    expect(Sorter.new(arr_to_sort, order_str8).sort).to eq(correct_order1)

    order_str9 = "aeqkkqevkkafa" #same as kvf

    expect(Sorter.new(arr_to_sort, order_str9).sort).to eq(correct_order4)

    order_str10 = "aopvadffafvpkk" #same as vfk

    expect(Sorter.new(arr_to_sort, order_str10).sort).to eq(correct_order3)

  end

end