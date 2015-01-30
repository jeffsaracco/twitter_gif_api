require 'open-uri'
require 'imgur'

class Scraper

  attr_reader :file
  attr_reader :imgur_link

  def initialize(url)
    response = open(url).read
    doc = Nokogiri::HTML(response)

    src       = doc.at_css("video source").attr('video-src')

    basename  = URI(src).path.gsub('/tweet_video/', '')
    folder    = "tmp/#{basename.gsub(/\.mp4$/, '')}"

    `mkdir -p tmp`
    `curl -s "#{src}" -o "tmp/#{basename}"`

    #folder for images
    `mkdir -p #{folder}`

    # convert the MP4 to 24 frames (4fps * 6s = 24)
    `ffmpeg -i "tmp/#{basename}" -y -f image2 -vf fps=fps=4 "#{folder}/output%04d.jpg"`

    # and also convert the MP4 to a GIF
    `ffmpeg -i "tmp/#{basename}" -y -pix_fmt rgb24 -r 4 "#{folder}.gif"`

    # optimize the gif
    # #   via http://superuser.com/questions/436056/how-can-i-get-ffmpeg-to-convert-a-mov-to-a-gif
    `convert -layers Optimize "#{folder}.gif" "#{folder}.gif"`

    `rm -rf #{folder}`
    `rm -rf #{folder}.mp4`

    @file = "#{folder}.gif"

    send_to_imgur
  end

  private

  def send_to_imgur
    client = Imgur.new('a13c4fe4af19853')
    image = Imgur::LocalImage.new(@file)
    uploaded = client.upload(image)
    @imgur_link = uploaded.link
  end
end
