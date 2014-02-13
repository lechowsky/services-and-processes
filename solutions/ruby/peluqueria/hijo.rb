
require 'C:\Users\Borja\Documents\Dropbox\txema\01_la_peluqueria\hilo.rb'

pool= ThreadPool.new(4)

1.upto(20) do |n|
  pool.dispatch(n) do |i| 
  puts "señora #{n} sentada en #{i}\n " 
  sleep 5
  puts "señora #{n} terminda\n"
  end
end
 

pool.shutdown