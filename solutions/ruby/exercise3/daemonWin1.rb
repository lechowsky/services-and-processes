# daemonWin1.rb
require 'rubygems'
require 'win32/service'
require 'tempfile'
require 'daemonize'
include Daemonize
include Win32

SERVICE_NAME = "windowService18"
SERVICE_DISPLAYNAME = "a window service"
if ARGV[0] == "register"
# Start the service.
linea = "#{`where ruby`.chomp}"
Service.create({
  :service_name       => SERVICE_NAME,
  :service_type       => Service::WIN32_OWN_PROCESS,
  :description        => 'A custom service I wrote just for fun',
  :start_type         => Service::AUTO_START,
  :error_control      => Service::ERROR_NORMAL,
  :binary_path_name   => "#{`where ruby`.chomp} -C #{`echo %cd%`.chomp} service.rb",
  :load_order_group   => 'Network',
  :display_name       => SERVICE_NAME
})
puts "Registered Service - " + SERVICE_DISPLAYNAME + linea
    Service.start(SERVICE_NAME)
    elsif ARGV[0] == "delete"
    # Stop the service.
        if Service.status(SERVICE_NAME).current_state == "running"
        Service.stop(SERVICE_NAME)
        end
    Service.delete(SERVICE_NAME)
    puts "Removed Service - " + SERVICE_DISPLAYNAME
    else
      if ENV["HOMEDRIVE"]!=nil
          # We are not running as a service, but the user didn't provide any
          # command line arguments. We've got nothing to do.
          puts "Usage: ruby rubysvc.rb [option]"
          puts " Where option is one of the following:"
          puts " register - To register the Service so it " +
          "appears in the control panel"
          puts " delete - To delete the Service from the control panel"
          exit
      end
      # If we got this far, we are running as a service.
   
end