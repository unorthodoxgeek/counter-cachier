module CounterCachier
  class Mounter

    attr_accessor :cachier

    def initialize(klass, name, &block)
      @klass = klass
      @name = name
      self.cachier = CounterCachier::Cachier.new(name, &block)
      define_methods
    end

    def define_methods
      #these local variables are set so they can be used inside the define_method blocks
      name = @name
      cachier = @cachier

      @klass.send :define_method, @name do
        CounterCachier.read(self, cachier)
      end

      @klass.send :define_method, "recalc_#{@name}" do
        cachier.write(self)
      end
    end
  end
end