#!/usr/bin/env ruby
$:.push "#{File.dirname __FILE__}/lib"
require 'markdown'

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
  [].map { |x| x }
  1 + 1
end
```

subheading
----------

asdf
eos
end



get '/' do
  haml :index, :locals => { :md => Markdown.to_html(md) }
end

configure do
  set :app_file, __FILE__
end

configure :development do
  enable :logging, :dump_errors, :raise_errors
end

configure :production do
  set :raise_errors, false
  set :show_exceptions, false
end
