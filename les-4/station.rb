# frozen_string_literal: true

require_relative 'modules'
require_relative 'accessors'
require_relative 'validation'

class Station
  include Factory
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :train_list, :name

  validate :name, :presence

  # rubocop:disable Style/ClassVars
  @@station_list = []
  # rubocop:enable Style/ClassVars
  @attempt = 0

  def self.all
    @@station_list.map(&:name)
  end

  def initialize(name)
    @name = name
    @train_list = []
    @@station_list << self
    register_instance
    validate!
    message
  end

  def add_train(train)
    @train_list << train
  end

  def remove_train(train)
    @train_list.delete(train)
  end

  def trains_by(type)
    @train_list.select { |train| train.type == type }
  end

  def trains(&block)
    @train_list.each(&block) if block_given?
  end

  protected

  def message
    puts "Станция #{name} успешно создана!"
  end
end
