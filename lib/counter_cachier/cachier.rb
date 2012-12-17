module CounterCachier
  class Cachier
    attr_accessor :name

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def recalc(object)
      @block.call(object)
    end

    def write(object)
      new_value = recalc(object)
      CounterCachier.write(object, new_value)
      new_value
    end
  end
end