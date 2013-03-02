#!/usr/bin/env ruby
$:.push "#{File.dirname __FILE__}/lib"
require 'sinatra'
require 'glorify'
require 'json'

Tilt.prefer Sinatra::Glorify::Template


set :markdown, :layout_engine => :haml

get '/' do
  #markdown :index, :layout => :layout
  markdown "posts/about_this_site".to_sym, :layout => :layout
end

get '/test' do
  markdown :test
end

get '/music' do
  haml :music
end

get '/sandbox' do
  haml :sandbox
end

get '/post/:post' do |p|
  markdown "posts/#{p}".to_sym, :layout => :layout
end

get '/env' do
  redirect to('https://raw.github.com/echohead/env/master/bootstrap')
end

post '/__push__' do
  begin
    puts "received push notification: #{params[:payload]}"
    push = JSON.parse(params[:payload])
    if push['repository']['name'] == 'echohead.org' and push['ref'] == 'refs/heads/master'
      puts "applying update."
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
  enable :logging
  set :raise_errors, false
  set :show_exceptions, false
end
