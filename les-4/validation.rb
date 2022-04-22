module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *arg)
      @validations ||= []
      @validations << { name: name, type: type, arg: arg }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}")
        send validation[:type], validation[:name], validation[:arg]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def presence(value, arg)
      raise 'Значение не может быть пустым' if value.nil? || value.empty?
    end

    def format(value, form)
      raise 'Неверный формат' if value !~ form
    end

    def type(value, clas)
      raise 'Несоответствие классу' unless clas.include? value
    end
  end
end
