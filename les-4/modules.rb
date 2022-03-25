module Factory
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
      self.instance_count ||= 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances
      self.class.instance_count += 1
    end
  end
end
