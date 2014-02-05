#! /usr/bin/env ruby
#

require 'rubygems'
require 'tempfile'

puts 'I\'m a daemon that create another daemon\n if you giveme a numeric param i\'ll create as many fork as you want'
      number = 0
      if (!ARGV[0].nil?)
      x=0
          while (x<ARGV[0].to_i) do
            fork do
                Process.daemon 
                number+=1
                file = Tempfile.new("daemon#{number}.log")
                loop do
                     file.puts('i\'m a new fork of a daemon')
                     file.flush
                     sleep 5
                end
            end
           x+=1
          end
      else
          fork do
                Process.daemon 
                file = Tempfile.new("daemon#{number}.log")
                loop do
                     file.puts('i\'m a new fork of a daemon')
                     file.flush
                     sleep 5
                end
            end
      end
    

puts 'working '
