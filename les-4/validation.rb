module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []
      types = { type => { name: name, args: args } }
      validations << types
    end

    module InstanceMethods
    
      def validate!
        self.class.validations.each do |types|
          types.each do |
    end

    end