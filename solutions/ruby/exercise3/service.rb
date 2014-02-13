require 'rubygems'
require 'win32/daemon'
include Win32

class TestDaemon < Daemon
  def service_main
      log 'started'
     while running?
        log 'running'
     
        sleep 5
        if File.exists? "C:\WeAreOne.txt"
        else
          File.open('C:\WeAreOne.txt', 'a')
        end
    end
  
        
      
  end
  
  def service_stop
    log 'ended'
    exit!
  end
  
  def log(text)
    File.open('log.txt', 'a') { |f| f.puts "#{Time.now}: #{text}" }
    
   
   
  end
end

TestDaemon.mainloop
