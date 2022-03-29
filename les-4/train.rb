require_relative 'modules'

class Train
  include Factory
  include InstanceCounter

  TRAIN_NUMBER = /^\w{3}-?\w{2}/.freeze
  # rubocop:disable Style/ClassVars
  @@train_list = []
  @@trains_number = []
  @@attempt = 0
  # rubocop:enable Style/ClassVars

  attr_reader :speed, :vans, :type, :get_route, :train_route, :current_station, :num

  def self.find(number)
    @@train_list.find do |train|
      puts train if train.num.equal?(number)
    end
  end

  def initialize(num, speed = 0)
    @num = num
    @speed = speed
    @vans = []
    @type = type
    register_instance
    @@train_list << self
    @@trains_number << self.num
  end

  def go(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def on_route(route)
    @train_route = route
    @current_station = route.full_route[0]
    @current_station.train_list << self
  end

  def move_ahead
    return unless next_station

    current_station.train_list.delete(self)
    @current_station = next_station
    current_station.train_list << self
  end

  def move_back
    return unless previous_station

    current_station.train_list.delete(self)
    @current_station = previous_station
    current_station.train_list << self
  end

  def previous_station
    return unless @current_station != train_route.full_route[0]

    cur_st = train_route.full_route.index(current_station)
    train_route.full_route[cur_st - 1]
  end

  def next_station
    return unless @current_station != train_route.full_route[-1]

    cur_st = train_route.full_route.index(current_station)
    train_route.full_route[cur_st + 1]
  end

  def add_van(van)
    @vans << van if speed.zero? && van.type == type
  end

  def remove_van(van)
    @vans.delete(van) if speed.zero?
  end

  def vans_iterator(&block)
    @vans.each(&block) if block_given?
  end

  protected

  def validate!
    raise 'Не правильный формат номера поезда' if @num.to_s !~ TRAIN_NUMBER
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
