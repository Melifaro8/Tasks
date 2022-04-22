require_relative 'modules'
require_relative 'accessors'
require_relative 'validation'

class Route
  include Accessors
  include Validation

  attr_reader :start_station, :final_station, :way_station

  @attempt = 0

  def initialize(start, final)
    @start_station = start
    @way_station = []
    @final_station = final
    validate!
    message
  end

  def add_station(station)
    @way_station << station
  end

  def full_route
    @full_route = [start_station, way_station, final_station].flatten
  end

  def remove_station(station)
    way_station.delete(station)
  end

  protected

  def message
    puts "Создан маршрут от #{@start_station.name} до #{@final_station.name}"
  end
end
