class Route
  
  attr_reader :start_station, :final_station, :full_route, :way_station

  def initialize(start, final)
    @start_station = start
    @way_station = []
    @final_station = final
  end

# Добавляет промежуточную станцию
  def add_station(station)
    @way_station << station
  end

# Выводит маршрут со всеми станциями в одном массиве
  def full_route
    @full_route= [start_station, way_station, final_station].flatten
  end

# Удаляет станцию из маршрута
  def remove_station(station)
    self.way_station.delete(station)
  end
end