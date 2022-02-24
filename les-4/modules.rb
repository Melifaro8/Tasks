module Factory
  
  def factory(name)
    self.factory_name = name
  end

  def manufacturer
    self.factory_name
  end

protected
  attr_accessor :factory_name
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods 
  end

  module ClassMethods
    attr_accessor :instance_count
    
    def instances
      @instance_count
    end
  end
  
  module InstanceMethods

    protected

    def register_instance
      self.class.instance_count ||= 0
      self.class.instance_count +=1
    end
  end
end
