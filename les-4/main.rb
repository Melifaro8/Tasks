require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'vans'

class RailRoad 
  attr_reader :stations, :trains, :routes, :vans 

  def initialize
    @stations= []
    @trains = []
    @routes = []
    @vans = []
  end

  def menu
    loop do
      puts "1. Создать станцию, поезд, маршрут или вагон"
      puts "2. Произвести операции с созданными объектами"
      puts "3. Вывести текущие данные об объектах"
      puts "0. Завершить программу"
      input = gets.chomp.to_i
      break if input == 0
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

  def separation
    puts "================================================================"
  end

  def station_list
    @stations.each.with_index do |station, index|
    puts "#{index + 1}. #{station.name}"
    end
    separation
  end

  def trains_list
    @trains.each.with_index do |train, index|
    puts "#{index + 1}. #{train.num}, #{train.type}"
    end
    separation
  end

  def route_list
    @routes.each.with_index do |route, index|
    puts "#{index + 1}. маршрут от #{route.start_station.name} до #{route.final_station.name}"
    end
    separation
  end

  def van_list
    @vans.each.with_index do |van, index|
      puts "#{index + 1}. вагон номер #{van.num}, #{van.type}"
    end
    separation
  end
  

  def create_object
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создать маршрут"
    puts "4. Создать вагон"
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
    puts "Введите название станции: "
    input = gets.chomp.to_s.capitalize 
    @stations << Station.new(input)
    puts "Создана станция #{input}"
    separation
  end

  def create_train
    puts "1. Создать пассажирский поезд"
    puts "2. Создать грузовой поезд"
    input = gets.chomp.to_i

    case input
      when 1
        puts "Введите номер поезда"
        num=gets.chomp.to_i 
        @trains << PassengerTrain.new(num)
        puts "Создан пассажирский поезд номер: #{num}"
        separation
      when 2
        puts "Введите номер поезда"
        num=gets.chomp.to_i 
        @trains << CargoTrain.new(num)
        puts "Создан грузовой поезд номер: #{num}"
        separation
    end
  end

  def create_route
    puts station_list
      
      puts "Введите название номер начальной станции: "
      start_st = gets.chomp.to_i 
      puts "Введите номер конечной станции: "
      final_st = gets.chomp.to_i
      @routes << Route.new(@stations[start_st - 1], @stations[final_st - 1])
      puts "Создан маршрут от #{stations[start_st-1].name} до #{stations[final_st - 1].name}"
      separation
  end

  def create_van
    puts "1. Создать пассажирский вагон."
    puts "2. Создать грузовой вагон."
    input = gets.chomp.to_i
    
    case input
      when 1
        puts "Введите номер вагона: "
        num= gets.chomp.to_i
        @vans << PassengerVan.new(num)
        puts "Создан пассажирский вагон номер #{num}"
        separation
      when 2
        puts "Введите номер вагона: "
        num= gets.chomp.to_i
        @vans << CargoVan.new(num)
        puts "Создан грузовой вагон номер #{num}"
        separation
    end
  end

  def operate_object
    puts "1. Произвести операции со станциями"
    puts "2. Произвести операции с поездами"
    puts "3. Произвести операции с маршрутами"
    input = gets.chomp.to_i

    case input
      when 1
        operate_station
      when 2
        operate_train
      when 3
        operate_route
    end
  end

  def operate_station 
    puts "1. Добавить поезд на станцию"
    puts "2. Отправить поезд со станции"
    puts "3. Вывести список поездов на станции"
    input = gets.chomp.to_i
    
    separation
    puts station_list
    puts "Выберите станцию: "
    station_input=gets.chomp.to_i
    
    case input
      when 1
        separation
        puts trains_list
        puts "Выберите поезд, который хотите добавить"
        train_input=gets.chomp.to_i
        @stations[station_input - 1].add_train(@trains[train_input - 1])
        puts "На станцию #{stations[station_input - 1].name} добавлен поезд номер #{@trains[train_input - 1].num}"
        separation
      when 2
        stations[station_input - 1].train_list.each_with_index do |train, index|
        puts "#{index + 1}. #{train.num}, #{train.type}"
        end
      
        puts "Выберите поезд, который хотите отправить со станции #{@stations[station_input - 1].name}"
        remove_input= gets.chomp.to_i
        @stations[station_input - 1].remove_train(@trains[remove_input - 1])
        puts "Поезд номер #{@trains[remove_input - 1].num} отправлен со станции  #{@stations[remove_input - 1].name}"
        separation
      when 3
        @stations[station_input - 1].train_list.each_with_index do |train, index|
          puts "#{index + 1}. #{train.num}, #{train.type}"
          separation
        end
      end
    end

  
  def operate_train
    puts "1. Задать скорость."
    puts "2. Остановить поезд."
    puts "3. Передать поезду маршрут."
    puts "4. Продвинуть вперед по маршруту."
    puts "5. Продвинуть назад по маршруту."
    puts "6. Прицепить вагон."
    puts "7. Отцепить вагон."
    input = gets.chomp.to_i

    case input
      when 1
      set_speed
      when 2
        @trains[train_input - 1].stop 
      when 3
        get_route
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

  def set_speed
    puts trains_list
    puts "Выберите поезд: "
    train_input=gets.chomp.to_i
    puts "Введите желаемую скорость поезда: "
    input = gets.chomp.to_i
    @trains[train_input - 1].go(input)
  end

  def get_route
    puts trains_list
    puts "Выберите поезд: "
    train_input=gets.chomp.to_i
    puts route_list
    puts "выберите маршрут"
    route_input = gets.chomp.to_i
    @trains[train_input - 1].get_route(@routes[route_input - 1])
    puts "Поезд номер #{@trains[train_input - 1].num} проследует по маршруту от #{@routes[route_input - 1].start_station.name} до #{@routes[route_input - 1].final_station.name} "
      
  end

  def move_ahead
    puts trains_list
     puts "Выберите поезд: "
    train_input=gets.chomp.to_i
    @trains[train_input - 1].move_ahead
    puts "Поезд находится на станции #{@trains[train_input - 1].current_station.name}"
  end

  def move_back
    puts trains_list
    puts "Выберите поезд: "
    train_input=gets.chomp.to_i
    @trains[train_input - 1].move_back
    puts "Поезд находится на станции #{@trains[train_input - 1].current_station.name}"
  end

  def add_van
    puts trains_list
    puts "Выберите поезд: "
    train_input=gets.chomp.to_i
    puts van_list
    puts "Выберите вагон: "
    van_input=gets.chomp.to_i
    @trains[train_input - 1].add_van(@vans[van_input - 1])
  end

  def remove_van
    puts trains_list
    puts "Выберите поезд: "
    train_input=gets.chomp.to_i
    puts van_list
    puts "Выберите вагон: "
    van_input=gets.chomp.to_i
    @trains[train_input - 1].remove_van(@vans[van_input - 1])
  end


  def operate_route
    puts route_list
    puts "Выберите маршрут: "
    route_input=gets.chomp.to_i

    puts "1. Добавить промежуточную станцию."
    puts "2. Удалить промежуточную станцию."
    input = gets.chomp.to_i
    
    case input
      when 1
        puts station_list
      puts "Выберите станцию для добавления в маршрут: "
      station_input=gets.chomp.to_i
      @routes[route_input - 1].add_station(@stations[station_input - 1])
      puts "В маршрут от #{@routes[route_input - 1].start_station.name} до #{@routes[route_input - 1].final_station.name} добавлена станция #{@stations[station_input - 1].name}"
      when 2
        @routes[route_input - 1].way_station.each.with_index do |station, index|
          puts "#{index + 1}. #{station.name}"
          end
        puts "Выберите станцию маршрута, которую хотите удалить: "
        remove_input=gets.chomp.to_i
        @routes[route_input - 1].remove_station(@routes[route_input - 1].way_station[remove_input-1])
    end
  end

  def list_object
    puts "1. Станция."
    puts "2. Поезд."
    puts "3. Маршрут."
    puts "4. Вагон."
    input = gets.chomp.to_i

    case input
      when 1
        puts station_list
        puts "Выберите станцию: "
        station_input=gets.chomp.to_i
        puts "Станция #{@stations[station_input - 1].name}"
        puts "Поезда на станции:"
         @stations[station_input - 1].train_list.each do |train| 
          puts train.num
         end 

      when 2
        puts trains_list
        puts "Выберите поезд: "
        train_input=gets.chomp.to_i
        puts "Поезд номер: #{@trains[train_input - 1].num}, тип: #{@trains[train_input - 1].type}, текущая скорость: #{@trains[train_input - 1].speed}, вагоны: #{@trains[train_input - 1].vans.eaсн {|van| puts van.num}}, текущая станция: #{@trains[train_input - 1].current_station.name}"
        puts "Маршрут: " 
        @trains[train_input - 1].train_route.each do |station|
        print station.name
        end 
      when 3
        puts route_list
        puts "Выберите маршрут: "
        route_input=gets.chomp.to_i
        puts "Полный маршрут: "
        @routes[route_input - 1].full_route do |station|
          print station.name
        end
      when 4
        puts van_list 
    end    
  end
   
=begin
  def seed
    @stations << Station.new('Москва')
    @stations << Station.new('Самара')
    @stations << Station.new('Тамбов')
    @stations << Station.new('Воронеж')
    @stations << Station.new('Иркутск')
    @trains << PassengerTrain.new(333)
    @trains << CargoTrain.new(888)
    @vans << CargoVan.new(88)
    @vans << PassengerVan.new(34)
    @vans << PassengerVan.new(35)
    @vans << PassengerVan.new(36)
    @routes << Route.new(@stations[0], stations[1])
    @trains[0].get_route(@routes[0])
    @routes[0].add_station(@stations[2])
    @routes[0].add_station(@stations[3])
    @trains[0].add_van(@vans[1])
    @trains[0].add_van(@vans[2])
    @trains[0].add_van(@vans[3])
    @stations[0].add_train(@trains[1])
  end
=end
end
