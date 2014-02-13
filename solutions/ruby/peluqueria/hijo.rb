
require 'C:\Users\Borja\Documents\Dropbox\txema\01_la_peluqueria\hilo.rb'

sillas = SillasVacias.new(4)

1.upto(20) do |n|
  sillas.corta(n) do |i| 
  puts "señora #{n} sentada en #{i}\n " 
  sleep 5
  puts "señora #{n} terminda\n"
  end
end

sillas.son_las_ocho
