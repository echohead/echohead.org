require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

RSpec::Matchers.define :link_to do |expected|
  match do |actual|
    actual =~ /href='#{expected}'/
  end
end

def ok_body(path)
  resp = get(path).body
  last_response.should be_ok
  resp
end
