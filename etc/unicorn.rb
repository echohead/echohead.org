worker_processes 4

listen "/tmp/.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 15

pid "/opt/echohead.org/run/unicorn.pid"

before_fork do |server, worker|
end

after_fork do |server, worker|
end
