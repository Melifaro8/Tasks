class Station
  attr_reader :train_list
  attr_accessor :station_name
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
  def show_trains
    pass_trains= self.train_list.select {|train| train.type == "pass"} 
    pass_trains.each do |train|
    puts "Passenger trains: #{train.num}"
    end
    cargo_trains= self.train_list.select {|train| train.type == "cargo"} 
    cargo_trains.each do |train|
    puts "Cargo trains: #{train.num}"
    end
  end  
end


class Route
  
  attr_reader :start_station, :final_station
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
    @full_route.each do |station|
      puts station.station_name
    end
  end

# Удаляет станцию из маршрута (НЕ РАБОТАЕТ!!!)
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
    @current_station 
    @train_route=[]
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
    vans = vans + 1
    end
  end

# Отцепить вагон
  def minus_van 
    if speed == 0 
    vans = vans - 1
    end
  end

# Возвращает количество вагонов
  def vans_num
    self.vans
  end    

# Принимает маршрут следования и перемещает поезд на первую станцию маршрута
  def get_route(route)
    @train_route = route.full_route
    @current_station = route.full_route[0]
    self.current_station.train_list << self 

  end

# Отправляет на станцию вперед
  def move_ahead
    self.current_station.train_list.delete(self)
    cur_st = self.train_route.index(current_station)
    @current_station = self.train_route[cur_st + 1]
    self.current_station.train_list << self 
  end

# Отправляет поезд на станцию назад
  def move_back
    self.current_station.train_list.delete(self)
    cur_st = self.train_route.index(current_station)
    @current_station = self.train_route[cur_st - 1]
    self.current_station.train_list << self 
  end

# Возвращает предыдущую, текущую и следующую станцию на маршруте (НЕ РАБОТАЕТ, НУЖНО ПРАВИЛЬНО ПРОПИСАТЬ ИТЕРАЦИЮ)
  def part_route
    cur_st = self.train_route.index(current_station)
    previous_st = self.train_route[cur_st - 1]
    cur_station = self.train_route[cur_st] 
    next_st = self.train_route[cur_st + 1]
    puts " previous station: #{previous_st.station_name}, current station: #{cur_station.station_name}, next station: #{next_st.station_name}"
  end
end