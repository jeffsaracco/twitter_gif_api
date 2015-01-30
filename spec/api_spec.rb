require 'spec_helper'

RSpec.describe "POST 'convert'", feature: true do
  it "gets the twitter image" do
    post '/convert', url: 'https://twitter.com/'
  end
end
