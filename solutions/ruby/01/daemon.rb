#!/usr/bin/env ruby

#first demon
    require 'rubygems'
require 'tempfile'
require 'daemons'

log=Tempfile.new('daemon.log')
puts "starting..."
#Daemons.daemonize 

Process.daemon
loop do
    log.puts "I'm a daemon doing demon's things."
    log.flush
    sleep 5
end

puts 'it\'s work'
