require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--color'
end

task :default => [:shotgun]

task :sass do
  desc 'watch sass for changes and recompile (does not exit)'
  exec 'sass --watch sass:public/css'
end

task :shotgun do
  desc 'start a development server'
  exec "bundle exec shotgun --host '*' ./app.rb"
end

task :pull do
  system 'git checkout master && git pull origin master' or raise `git pull 2>&1`
end

task :install do
  system('bundle install') or raise `bundle install 2>&1`
end


ROOT = File.dirname __FILE__
