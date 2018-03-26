require 'spec_helper'

feature 'External request' do
  it 'queries access_token to DHL Parcel API' do
    uri = URI('https://api-gw-accept.dhlparcel.nl/authenticate/api-key')
    response = Net::HTTP::Post.new(uri)
    expect(response).to be_an_instance_of(Net::HTTP::Post)
  end

  it 'queries generate label to DHL Parcel API' do
    uri = URI('https://api-gw-accept.dhlparcel.nl/labels')
    response = Net::HTTP::Post.new(uri)
    expect(response).to be_an_instance_of(Net::HTTP::Post)
  end
end