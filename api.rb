require 'open-uri'
require 'bundler'
Bundler.require

get '/' do
  "hello jeff"
end

post '/convert' do
  content_type :json

  twitter_url = params[:url]
  binding.pry

  if twitter_url

  else
    {error: 'parameter :url missing'}
  end
end
