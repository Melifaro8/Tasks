require_relative 'modules'

class Train
  include Factory
  include InstanceCounter
  attr_reader :speed, :vans, :type, :get_route, :train_route, :current_station, :num

  TRAIN_NUMBER = /^[\w]{3}-?[\w]{2}/
  @@train_list = []
  @@trains_number = []
  @@attempt = 0

  def self.find(number)
    @@train_list.find do |train|
      puts train if train.num.equal?(number)
    end
  end

  def initialize(num, speed = 0)
    @num = num
    @speed = speed
    @vans =[]
    @type = type
    register_instance
    @@train_list<<self
    @@trains_number<<self.num
  end

  def go (speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end 

  def get_route(route)
    @train_route = route
    @current_station = route.full_route[0]
    @current_station.train_list << self 
  end

  def move_ahead
    return unless next_station
    self.current_station.train_list.delete(self)
    @current_station = next_station
    self.current_station.train_list << self 
  end

  def move_back
    return unless previous_station
    self.current_station.train_list.delete(self)
    @current_station = previous_station 
    self.current_station.train_list << self 
  end

  def previous_station
    if @current_station != self.train_route.full_route[0]
      cur_st = self.train_route.full_route.index(current_station)
      self.train_route.full_route[cur_st - 1]
    end
  end

  def next_station
    if @current_station != self.train_route.full_route[-1]  
      cur_st = self.train_route.full_route.index(current_station)
      self.train_route.full_route[cur_st + 1]
    end
  end

  def add_van(van)
    @vans << van if speed.zero? && van.type == self.type
  end
  
  def remove_van(van)
    @vans.delete(van) if speed.zero?
  end

  protected

  def validate!
    raise "Не правильный формат номера поезда" if @num.to_s !~ TRAIN_NUMBER
  end
end


class PassengerTrain < Train
  attr_reader :type, :num
  
  def initialize(num)
    super
    @type = :passenger
    validate!
  end
end


class CargoTrain < Train
  attr_reader :type, :num

  def initialize(num)
    super
    @type = :cargo
    validate!
  end
end