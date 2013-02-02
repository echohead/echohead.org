#!/usr/bin/env ruby
$:.push "#{File.dirname __FILE__}/lib"
require 'sinatra'
require 'glorify'

Tilt.prefer Sinatra::Glorify::Template

# for all markdown files, use post.haml as layout
set :markdown, :layout_engine => :haml

get '/' do
  markdown :index, :layout => :layout
end

get '/test' do
  markdown :test
end

get '/:post' do
  markdown params[:post].to_sym
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
