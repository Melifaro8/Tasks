require_relative 'modules'

class Station
  include Factory
  include InstanceCounter

  attr_reader :train_list, :name

  @@station_list = []
  @attempt = 0

  def self.all
    @@station_list.map(&:name)
  end

  def initialize(name)
    @name = name
    validate!
    @train_list = []
    @@station_list << self
    register_instance
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

  def validate!
    raise 'Название станции не может быть пустым' if @name.empty?
  end

  def message
    puts "Станция #{name} успешно создана!"
  end
end
