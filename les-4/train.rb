class Train
  attr_reader :speed, :vans, :type, :get_route, :train_route, :current_station, :num

  def initialize(num, speed = 0)
    @num = num
    @speed = speed
    @vans =[]
  end

# Набирает скорость
  def go (speed)
    @speed = speed
  end

# Останавлиает поезд
  def stop
    @speed = 0
  end 

# Принимает маршрут следования и перемещает поезд на первую станцию маршрута
  def get_route(route)
    @train_route = route
    @current_station = route.full_route[0]
    @current_station.train_list << self 
  end

# Отправляет на станцию вперед
  def move_ahead
    return unless next_station
    self.current_station.train_list.delete(self)
    @current_station = next_station
    self.current_station.train_list << self 
  end

# Отправляет поезд на станцию назад
  def move_back
    return unless previous_station
    self.current_station.train_list.delete(self)
    @current_station = previous_station 
    self.current_station.train_list << self 
  end

# Возвращает предыдущую станцию на маршруте
  def previous_station
    if @current_station != self.train_route.full_route[0]
      cur_st = self.train_route.full_route.index(current_station)
      self.train_route.full_route[cur_st - 1]
    end
  end
# Возвращает следующую станцию на маршруте
  def next_station
    if @current_station != self.train_route.full_route[-1]  
      cur_st = self.train_route.full_route.index(current_station)
      self.train_route.full_route[cur_st + 1]
    end
  end

   # Прицепить вагон
  def add_van(van)
    @vans << van if speed.zero? && van.type == self.type
  end
  
  # Отцепить вагон
    def remove_van(van)
      @vans.delete(van) if speed.zero?
    end

end


class PassengerTrain < Train
  attr_reader :type
  
  def initialize(num)
    super
    @type = "пассажирский"
  end
end


class CargoTrain < Train
  attr_reader :type

  def initialize(num)
    super
    @type = "грузовой"
  end

end