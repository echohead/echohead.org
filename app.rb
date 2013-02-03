#!/usr/bin/env ruby
$:.push "#{File.dirname __FILE__}/lib"
require 'sinatra'
require 'glorify'
require 'json'

Tilt.prefer Sinatra::Glorify::Template


set :markdown, :layout_engine => :haml

get '/' do
  markdown :index, :layout => :layout
end


get '/test' do
  markdown :test
end

get '/post/:post' do
  #markdown params[:post].to_sym, :layout => :layout
  markdown "posts/#{params[:post]}".to_sym, :layout => :layout
end

post '/__push__' do
  begin
    puts "foo"
    puts params[:payload]
    puts "foo"
    push = JSON.parse(params[:payload])
    puts "foo"
    puts push.inspect
    puts "foo"
    puts "foo"*30
    puts push['repository']['name']
    puts push['ref']
    if push['repository']['name'] == 'echohead.org' and push['ref'] == 'refs/heads/master'
      puts "updating."
      fork do
        exec "#{File.expand_path(File.dirname __FILE__)}/bin/update"
      end
    end
    "ok"
  rescue
    halt 400
  end
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
