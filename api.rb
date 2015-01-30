require 'bundler'
Bundler.require

require './scraper'

get '/' do
  "hello jeff"
end

get '/convert' do
  file = Scraper.new(params[:url]).file
  gif = File.open(file)

  # `rm -rf #{file}`

  send_file gif
end

post '/convert' do
  content_type :json

  twitter_url = params[:url]

  if twitter_url
    file = Scraper.new(params[:url]).file
    gif = File.open(file)

    # `rm -rf #{file}`

    send_file gif
  else
    {error: 'parameter :url missing'}
  end
end
