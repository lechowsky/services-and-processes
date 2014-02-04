#!/usr/bin/ruby -w
# daemonize_daemon.rb
require 'tempfile'
puts 'About to daemonize.'
Process.daemon
log = File.open('coño.txt','w')
loop do
log.puts "I'm a daemon, doin' daemon things."
log.flush
sleep 5
end