class Station
  
  attr_reader :train_list
  attr_accessor :add_train
  attr_accessor :station_name
  attr_accessor :station
  def initialize (station_name)
    @station_name = station_name.to_sym
  end 
  
  # прибытие поезда на станцию
  def add_train (train)
    @train_list << train
    
  end

  # отправление поезда со станции
  def remove_train (train)
    @train_list.delete(train)
    
  end
  
end


class Route
  
  attr_accessor :start_station
  attr_accessor :final_station
  attr_accessor :route
  attr_reader :way_station

  def initialize (start_station, final_station)
    @start_station = @station
    @way_station = []
    @final_station = @station
  end

# Добавляет промежуточную станцию
  def add_station= (station_name)
    @way_station << Station.new(station_name)
  end

# Выводит маршрут со всеми станциями в одном массиве
  def full_route
    @full_route= [start_station, way_station, final_station].flatten
  end

# Удаляет станцию из маршрута (НЕ РАБОТАЕТ!!!)
  def remove_station= (station_namе)
    @way_station.delete("#{station_namе}")
  end

end


class Train
  attr_reader :speed, :vans, :type, :get_route, :train_route, :current_station

  def initialize (num, type, vans, speed = 0)
    @num = num
    @speed = speed
    @vans = vans
    @type = type
    @current_station
  end

# Набирает скорость
  def go= (speed)
    @speed = speed
  end

# Останавлиает поезд
  def stop
    self.speed = 0
  end 

# Прицепить вагон
  def plus_van 
    if speed == 0 
    self.vans = vans + 1
    end
  end

# Отцепить вагон
  def minus_van 
    if speed == 0 
    self.vans = vans - 1
    end
  end

# Принимает маршрут следования и перемещает поезд на первую станцию маршрута
  def get_route(route)
    @train_route = route.full_route
    @current_station = route.start_station
  end

# Отправляет на станцию вперед (НЕ РАБОТАЕТ ИТЕРАЦИЯ!)
  def move_ahead 
   @current_station = train_route
  end

# Отправляет поезд на станцию назад (НЕ РАБОТАЕТ ИТЕРАЦИЯ!)
  def move_back
    @current_station = train_route[current_station - 1]
  end

# Возвращает предыдущую, текущую и следующую станцию на маршруте (НЕ РАБОТАЕТ, НУЖНО ПРАВИЛЬНО ПРОПИСАТЬ ИТЕРАЦИЮ)
  def short_route
    puts   "#{@current_station[ - 1]}, #{@current_station}, #{@current_station[ + 1]} "
  end

end