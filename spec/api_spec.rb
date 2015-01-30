require 'spec_helper'

RSpec.describe "POST 'convert'", feature: true do
  it "gets the twitter image" do
    post '/convert', url: 'https://twitter.com/GIFs/status/560964454301433857', format: :json
    # binding.pry
  end
end
