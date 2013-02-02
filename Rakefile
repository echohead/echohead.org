task :default => [:shotgun]

task :sass do
  desc 'watch sass for changes and recompile (does not exit)'
  exec 'sass --watch sass:public/css'
end

task :shotgun do
  desc 'start a development server'
  exec "bundle exec shotgun --host '*' ./app.rb"
end
