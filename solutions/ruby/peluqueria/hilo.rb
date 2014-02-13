require 'thread'

class ThreadPool
  def initialize (max_clients)
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
    @pool << Thread.current
    begin
      yield *args
    rescue => e
      exception( self, e, *args)
    ensure
      @pool_mutex.synchronize do
        @pool.delete(Thread.current)
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
