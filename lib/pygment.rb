require 'nokogiri'
require 'sinatra'
require 'net/http'
require 'uri'

module Pygment
  PYGMENTS_URI = 'http://pygments.appspot.com/'

  def self.colorize(html)
    doc = Nokogiri::HTML html
    doc.search("pre > code[class]").each do |code|
      response = Net::HTTP.post_form(URI.parse(PYGMENTS_URI),
                  { 'lang' => code[:class],
                    'code' => code.text.rstrip })
      code.parent.replace response.body
    end
    doc.search('//body').children.to_s
  end
end
