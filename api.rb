require 'bundler'
Bundler.require

require './scraper'

get '/' do
  "hello jeff"
end

get '/convert' do
  content_type :json

  twitter_url = params[:url]

  if twitter_url
    convert_image(twitter_url)
  else
    {error: 'parameter :url missing'}
  end
end

post '/convert' do
  content_type :json

  twitter_url = params[:url]

  if twitter_url
    convert_image(twitter_url)
  else
    {error: 'parameter :url missing'}
  end
end

def convert_image(url)
  scraper = Scraper.new(url)
  gif = File.open(scraper.file)
  imgur_link = scraper.imgur_link

  encoded = Base64.encode64(gif.read).gsub("\n",'')

  {
    link: imgur_link,
    data: "data:image/png;base64,#{encoded}",
  }.to_json
end
