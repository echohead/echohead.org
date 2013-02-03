task :default => [:shotgun]

task :sass do
  desc 'watch sass for changes and recompile (does not exit)'
  exec 'sass --watch sass:public/css'
end

task :shotgun do
  desc 'start a development server'
  exec "bundle exec shotgun --host '*' ./app.rb"
end

task :update => [:pull, :install, :restart] do
  desc 'pull from origin and restart service'
end

task :start do
  exec 'start echohead.org'
end

task :restart do
  exec 'restart echohead.org'
end

task :pull do
  system 'git pull' or raise `git pull 2>&1`
  exec 'restart echohead.org'
end

task :install do
  system('bundle install') or raise `bundle install 2>&1`

  File.open("/home/tim/.init/echohead.org.conf", 'w') do |f|
    f.write <<-eos
setuid tim
respawn
exec "cd #{ROOT} && echo "foo" && rake prod"
eos
  end
end

task :prod do
  exec "cd #{ROOT} && bundle exec shotgun --host '*' --port 9400 app.rb"
end


ROOT = File.dirname __FILE__
