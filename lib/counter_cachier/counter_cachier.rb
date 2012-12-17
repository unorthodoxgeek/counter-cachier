module CounterCachier
  class << self
    def redis
      @redis ||= Redis.new
    end

    def key(object, name)
      "counter_cachier::#{object.class.to_s}::#{object.id}::#{name}"
    end

    def read(object, cachier)
      value = redis.read(key(object, cachier.name))
      if value.nil?
        value = cachier.write(object)
      end
      value
    end

    def write(object, name, value)
      redis.write key(object, name), value
    end
  end

  def self.included(base)
    base.extend ClassMethods
    class << base
      attr_accessor :cachiers
    end
  end

  module ClassMethods
    def counter_cachier(name, options = {}, &block)
      self.cachiers ||= {}
      self.cachiers[name] = Mounter.new(self, name, &block)
      if options[:async]
        later "recalc_#{name}", queue: options[:queue] || :long
      end
    end
  end
end