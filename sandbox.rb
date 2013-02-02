#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'haml'
require 'nokogiri'
require 'redcarpet'
require 'sinatra'

def md
<<-eos
heading
=======
- bullet points

# a test post

this is a test post
to try things out
it include some code:
---

```ruby
def foo
  1 + 1
end
```

subheading
----------

asdf
eos
end



r = Redcarpet::Markdown.new(
  Redcarpet::Render::HTML,
#  :hard_wrap => true,
  :autolink => true,
  :space_after_headers => true,
  :fenced_code_blocks => true
)

class SyntaxHighlighter
  PYGMENTS_URI = 'http://pygments.appspot.com/'
  attr_accessor :doc

  def initialize(html)
    self.doc = Nokogiri::HTML(html)
    doc.search("pre > code[class]").each do |code|
      request = Net::HTTP.post_form(URI.parse(PYGMENTS_URI),
                  { 'lang' => code[:class],
                    'code' => code.text.rstrip })
      code.parent.replace request.body
    end
  end

  def to_s
    doc.search("//body").children.to_s
  end
end

get '/' do
  haml :index, :locals => { :md => SyntaxHighlighter.new(r.render(md)).to_s }
end
