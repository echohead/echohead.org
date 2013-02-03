task :default => [:shotgun]

task :sass do
  desc 'watch sass for changes and recompile (does not exit)'
  exec 'sass --watch sass:public/css'
end

task :shotgun do
  desc 'start a development server'
  exec "bundle exec shotgun --host '*' ./app.rb"
end

task :update do
  desc 'pull from origin and restart service'
end

task :start do
  desc 'start local prod server'
end

task :restart do
  desc 'restart local prod server'
end

task :pull do
  system 'git checkout master && git pull origin master' or raise `git pull 2>&1`
end

task :install do
  system('bundle install') or raise `bundle install 2>&1`
end


ROOT = File.dirname __FILE__
