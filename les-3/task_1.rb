class Station
  attr_reader :train_list, :station_name

  def initialize(station_name)
    @station_name = station_name
    @train_list = []
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


class Route
  
  attr_reader :start_station, :final_station, :full_route
  attr_reader :way_station

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


class Train
  attr_reader :speed, :vans, :type, :get_route, :train_route, :current_station, :num

  def initialize(num, type, vans, speed = 0)
    @num = num
    @speed = speed
    @vans = vans
    @type = type
  end

# Набирает скорость
  def go (speed)
    @speed = speed
  end

# Останавлиает поезд
  def stop
    @speed = 0
  end 

# Прицепить вагон
  def plus_van 
    @vans += 1 if speed.zero?
  end

# Отцепить вагон
  def minus_van 
    @vans -= 1 if speed.zero?
  end

# Возвращает количество вагонов
  def vans_num
    @vans
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
end


