require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'vans'
require_relative 'modules'
require_relative 'accessors'
require_relative 'validation'

class RailRoad
  attr_reader :stations, :trains, :routes, :vans

  @attempt = 0

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @vans = []
  end

  def menu
    loop do
      puts '1. Создать станцию, поезд, маршрут или вагон'
      puts '2. Произвести операции с созданными объектами'
      puts '3. Вывести текущие данные об объектах'
      puts '0. Завершить программу'
      input = gets.chomp.to_i
      break if input.zero?

      case input
      when 1
        create_object
      when 2
        operate_object
      when 3
        list_object
      end
    end
  end

  private

  def station_list
    @stations.each.with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
  end

  def trains_list
    @trains.each.with_index do |train, index|
      puts "#{index + 1}. #{train.num}, #{train.type}"
    end
  end

  def route_list
    @routes.each.with_index do |route, index|
      puts "#{index + 1}. маршрут от #{route.start_station.name} до #{route.final_station.name}"
    end
  end

  def van_list
    @vans.each.with_index do |van, index|
      if van.type == :cargo
        puts "#{index + 1}. вагон номер #{van.num}, тип: грузовой, объем: #{van.volume}"
      else
        puts "#{index + 1}. вагон номер #{van.num}, тип: пассажирский, количество мест: #{van.seats}"
      end
    end
  end

  def create_object
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут'
    puts '4. Создать вагон'
    input = gets.chomp.to_i

    case input
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      create_van
    end
  end

  def create_station
    puts 'Введите название станции: '
    name = gets.chomp.to_s.capitalize
    @stations << Station.new(name)
  rescue RuntimeError => e
    puts e.class.name
    puts e.message
    @attempt += 1
    puts 'Попробуйте ввести название станции заново'
    retry if @attempt < 1
  end

  def create_train
    puts '1. Создать пассажирский поезд'
    puts '2. Создать грузовой поезд'
    input = gets.chomp.to_i

    case input
    when 1
      puts 'Введите номер поезда'
      num = gets.chomp.to_s
      @trains << PassengerTrain.new(num)
    when 2
      puts 'Введите номер поезда'
      num = gets.chomp.to_s
      @trains << CargoTrain.new(num)
    end
  rescue StandardError => e
    puts e.message
    puts e.class.name
    @attempt += 1
    puts 'Попробуйте ввести номер поезда заново'
    retry if @attempt < 1
  end

  def create_route
    puts station_list

    puts 'Введите название номер начальной станции: '
    start_st = gets.chomp.to_i
    puts 'Введите номер конечной станции: '
    final_st = gets.chomp.to_i
    @routes << Route.new(@stations[start_st - 1], @stations[final_st - 1])
  rescue StandardError
    @attempt += 1
    puts 'Попробуйте выбрать маршрут заново'
    retry if @attempt < 1
  end

  def create_van
    puts '1. Создать пассажирский вагон.'
    puts '2. Создать грузовой вагон.'
    input = gets.chomp.to_i

    case input
    when 1
      create_passenger_van
    when 2
      create_cargo_van
    end
  rescue StandardError
    @attempt += 1
    puts 'Попробуйте ввести номер вагона заново'
    retry if @attempt < 1
  end

  def create_passenger_van
    puts 'Введите номер вагона: '
    num = gets.chomp.to_i
    puts 'Введите количество мест: '
    seats = gets.chomp.to_i
    @vans << PassengerVan.new(num, seats)
  end

  def create_cargo_van
    puts 'Введите номер вагона: '
    num = gets.chomp.to_i
    puts 'Введите объем вагона: '
    volume = gets.chomp.to_f
    @vans << CargoVan.new(num, volume)
  end

  def operate_object
    puts '1. Произвести операции со станциями'
    puts '2. Произвести операции с поездами'
    puts '3. Произвести операции с маршрутами'
    puts '4. Занять место иль объем в вагоне'
    input = gets.chomp.to_i

    case input
    when 1
      operate_station
    when 2
      operate_train
    when 3
      operate_route
    when 4
      operate_vans
    end
  end

  def operate_station
    puts '1. Добавить поезд на станцию'
    puts '2. Отправить поезд со станции'
    puts '3. Вывести список поездов на станции'
    input = gets.chomp.to_i

    puts station_list
    puts 'Выберите станцию: '
    station = gets.chomp.to_i

    case input
    when 1
      add_train_to_station
    when 2
      go_train
    when 3
      @stations[station - 1].trains { |train| puts "Поезд номер: #{train.num}, тип: #{train.type}" }
    end
  end

  def add_train_to_station
    puts trains_list
    puts 'Выберите поезд, который хотите добавить'
    choise = gets.chomp.to_i
    @stations[station - 1].add_train(@trains[choise - 1])
    puts "На станцию #{stations[station - 1].name} добавлен поезд номер #{@trains[choise - 1].num}"
  end

  def go_train
    stations[station - 1].train_list.each_with_index do |train, index|
      puts "#{index + 1}. #{train.num}, #{train.type}"
    end

    puts "Выберите поезд, который хотите отправить со станции #{@stations[station - 1].name}"
    remove = gets.chomp.to_i
    @stations[station - 1].remove_train(@trains[remove - 1])
    puts "Поезд номер #{@trains[remove - 1].num} отправлен со станции  #{@stations[station - 1].name}"
  end

  def operate_train
    puts '1. Задать скорость.'
    puts '2. Остановить поезд.'
    puts '3. Передать поезду маршрут.'
    puts '4. Продвинуть вперед по маршруту.'
    puts '5. Продвинуть назад по маршруту.'
    puts '6. Прицепить вагон.'
    puts '7. Отцепить вагон.'
    input = gets.chomp.to_i

    case input
    when 1
      set_speed
    when 2
      train_stop
    when 3
      on_route
    when 4
      move_ahead
    when 5
      move_back
    when 6
      add_van
    when 7
      remove_van
    end
  end

  def train_stop
    @trains[train - 1].stop
  end

  def set_speed
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    puts 'Введите желаемую скорость поезда: '
    input = gets.chomp.to_i
    @trains[train - 1].go(input)
  end

  def on_route
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    puts route_list
    puts 'выберите маршрут'
    route = gets.chomp.to_i
    @trains[train - 1].on_route(@routes[route - 1])
    puts 'Поезд встал на маршрут'
  end

  def move_ahead
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    @trains[train - 1].move_ahead
    puts "Поезд находится на станции #{@trains[train - 1].current_station.name}"
  end

  def move_back
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    @trains[train - 1].move_back
    puts "Поезд находится на станции #{@trains[train - 1].current_station.name}"
  end

  def add_van
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    puts van_list
    puts 'Выберите вагон: '
    van = gets.chomp.to_i
    @trains[train - 1].add_van(@vans[van - 1])
  end

  def remove_van
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    puts van_list
    puts 'Выберите вагон: '
    van = gets.chomp.to_i
    @trains[train - 1].remove_van(@vans[van - 1])
  end

  def operate_route
    puts route_list
    puts 'Выберите маршрут: '
    route = gets.chomp.to_i

    puts '1. Добавить промежуточную станцию.'
    puts '2. Удалить промежуточную станцию.'
    input = gets.chomp.to_i

    case input
    when 1
      puts station_list
      puts 'Выберите станцию для добавления в маршрут: '
      choise = gets.chomp.to_i
      @routes[route - 1].add_station(@stations[choise - 1])
      puts "В маршрут добавлена станция #{@stations[choise - 1].name}"
    when 2
      @routes[route - 1].way_station.each.with_index do |station, index|
        puts "#{index + 1}. #{station.name}"
      end
      puts 'Выберите станцию маршрута, которую хотите удалить: '
      remove = gets.chomp.to_i
      @routes[route - 1].remove_station(@routes[route - 1].way_station[remove - 1])
    end
  end

  def operate_vans
    puts van_list
    puts 'Выберите вагон: '
    input = gets.chomp.to_i

    if @vans[input - 1].type == :cargo
      puts 'Укажите объем, который хотите занять: '
      volume = gets.chomp.to_f
      @vans[input - 1].occupy_volume(volume)
      puts "В грузовом вагоне №#{@vans[input - 1].num} занят объем #{volume}, осталось #{@vans[input - 1].free_volume}"
    else
      @vans[input - 1].take_seat
      puts "В пассажирском вагоне №#{@vans[input - 1].num} занято одно место,
      свободных мест: #{@vans[input - 1].avaliable_seats}."
    end
  end

  def list_object
    puts '1. Станция.'
    puts '2. Поезд.'
    puts '3. Маршрут.'
    puts '4. Список вагонов поезда.'
    input = gets.chomp.to_i

    case input
    when 1
      list_station
    when 2
      list_train
    when 3
      list_route
    when 4
      list_vans
    end
  end

  def list_station
    puts station_list
    puts 'Выберите станцию: '
    station = gets.chomp.to_i
    puts "Станция #{@stations[station - 1].name}"
    puts 'Поезда на станции:'
    @stations[station - 1].trains { |train| puts "Поезд номер: #{train.num}, тип: #{train.type}" }
  end

  def list_train
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    puts "Поезд номер: #{@trains[train - 1].num}"
    puts "тип: #{@trains[train - 1].type}"
    puts "текущая скорость: #{@trains[train - 1].speed}"
    puts "вагоны: #{@trains[train - 1].vans.map(&:num)}"
  end

  def list_route
    puts route_list
    puts 'Выберите маршрут: '
    route = gets.chomp.to_i
    puts "Полный маршрут: #{@routes[route - 1].full_route.map(&:name)}"
  end

  def list_vans
    puts trains_list
    puts 'Выберите поезд: '
    train = gets.chomp.to_i
    if @trains[train - 1].type == :cargo
      @trains[train - 1].vans_iterator do |van|
        puts "Вагон №#{van.num}, тип: #{van.type}, занято: #{van.occupied_volume}, свободно: #{van.free_volume}"
      end
    else
      @trains[train - 1].vans_iterator do |van|
        puts "Вагон №#{van.num}, тип: #{van.type}, занято: #{van.occupied_seats}, свободно: #{van.avaliable_seats}"
      end
    end
  end

  def seed
    @stations << Station.new('Москва')
    @stations << Station.new('Самара')
    @stations << Station.new('Тамбов')
    @stations << Station.new('Воронеж')
    @stations << Station.new('Иркутск')
    @trains << PassengerTrain.new(33_333)
    @trains << CargoTrain.new(88_855)
    @vans << CargoVan.new(88, 45)
    @vans << PassengerVan.new(34, 80)
    @vans << PassengerVan.new(35, 90)
    @vans << PassengerVan.new(36, 58)
    @routes << Route.new(@stations[0], stations[1])
    @trains[0].on_route(@routes[0])
    @routes[0].add_station(@stations[2])
    @routes[0].add_station(@stations[3])
    @trains[0].add_van(@vans[1])
    @trains[0].add_van(@vans[2])
    @trains[0].add_van(@vans[3])
  end
end
