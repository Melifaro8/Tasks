require_relative 'modules'

class Station
  attr_reader :train_list, :name

  @@station_list = []

  def self.all
    @@station_list.each do |station|
      puts station.name
    end
  end

  def initialize(name)
    register_instance
    @name = name
    @train_list = []
    @@station_list<<self
  end 
  
  # прибытие поезда на станцию
  def add_train(train)
    @train_list << train
  end

  # отправление поезда со станции
  def remove_train(train)
    self.train_list.delete(train)  
  end
  
# Возвращает список поездов на станции по типу
  def trains_by(type)
    self.train_list.select {|train| train.type == type}
  end  
end