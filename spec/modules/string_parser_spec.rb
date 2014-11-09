require 'rails_helper'

describe StringParser do

  let(:dummy_class) {
    class DummyClass
      include StringParser
    end
  }

  it "parses tab delimited string to array of arrays that are separated elements" do

    tab_string = "Led Zeppelin\tlameness\nplatypuses\tlikely things\nLed Zeppelin\tMaroon 5\nBoulder, CO\tHouston\n\n\nthis \t that\nwhatevs\t\n\t\t\n\t,\n"

    this = [["Led Zeppelin", "lameness"],
            ["platypuses", "likely things"],
            ["Led Zeppelin", "Maroon 5"],
            ["Boulder, CO", "Houston"],
            ["this ", " that"],
            ["whatevs", nil],
            [nil, nil, nil],
            [nil, ","]]

    expect(dummy_class.new.parse_tabs(tab_string)).to eq(this)
    expect(dummy_class.new.parse_tabs("")).to eq([])
  end

  it "parses sort options string to array of uniq chars f,k, or v in the order given" do

    expect(dummy_class.new.parse_opts("")).to eq([])
    expect(dummy_class.new.parse_opts("fkv")).to eq(["f", "k", "v"])
    expect(dummy_class.new.parse_opts("f")).to eq(["f"])
    expect(dummy_class.new.parse_opts("k")).to eq(["k"])
    expect(dummy_class.new.parse_opts("v")).to eq(["v"])
    expect(dummy_class.new.parse_opts("kv")).to eq(["k", "v"])
    expect(dummy_class.new.parse_opts("vk")).to eq(["v", "k"])
    expect(dummy_class.new.parse_opts("bfksav")).to eq(["f", "k", "v"])
    expect(dummy_class.new.parse_opts("vvvasdfpoifkf")).to eq(["v", "f", "k"])
    expect(dummy_class.new.parse_opts("bliggityBlah!")).to eq([])

  end

end