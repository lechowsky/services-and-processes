require 'thread'

class ThreadPool
  def initialize (max_clients, mi_pelu)
    @mi_pelu = mi_pelu
    @pool=[]
    @max_clients= max_clients
    @pool_mutex= Mutex.new
    @pool_cv = ConditionVariable.new
    
  
  end

def dispatch(*args)
  Thread.new do
    @pool_mutex.synchronize do 
      while @pool.size >=@max_clients
        puts "disculpe ya tenemos a #{@pool.size} clientes en las sillas, \n esperen a ser atendidos"
        @pool_cv.wait(@pool_mutex)
      end
    end
    @pool << [Thread.current mi_pelu.ocupa_silla]
    begin
      yield *args
    rescue => e
      exception( self, e, *args)
    ensure
      @pool_mutex.synchronize do
        @pool.delete_if do |compuesto| 
	  mi_pelu.libera_silla compuesto[1] if compuesto[0] == Thread.current 
	  compuesto[0] == Thread.current 
      end
        @pool_cv.signal
      end
    end
  end


def shutdown
  @pool_mutex.synchronize do
    @pool_cv.wait(@pool_mutex) until @pool.empty?
  end
end
      
      def exception(thread, exception, *original_argumnents)
        puts "la pelu se vino abajo con el cliente #{thread}: por el siguiente motivo #{exception}"
      end
end
end

class SillasVacias < Array

  def initialize(total)
    1.upto(total) { |i| self << i }
    @pool = ThreadPool.new(total, self)
  end

  def ocupa_silla
    self.shift
  end

  def libera_silla(number)
    self.push(number)
  end
     
  def corta(i)
     @pool.dispatch(i)
  end

  def son_las_ocho
    @pool.shutdown
  end
end


