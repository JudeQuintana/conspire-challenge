require 'rails_helper'

describe 'get /query' do

  let(:partial_expected) {
    #yes this is actual text provided by conspire for the challenge
    {"filename" => "claims_to_fame.txt", "key" => "Boulder, CO", "value" => "mountains and marijuana"}
  }
  it 'tests /query endpoint returns a json blob' do

    get '/query'

    expect(response.code.to_i).to eq 200
    expect(JSON.parse(response.body)).to include(partial_expected)

  end

  it 'test /query endpoint with search params' do
    get '/query?sort=fkv'

    expect(response.code.to_i).to eq 200
    expect(JSON.parse(response.body)).to include(partial_expected)
  end

end