require_relative 'modules'

class Van
  include Factory
  attr_reader :num, :type, :seats
  
  @@attempt = 0

 protected

  def validate!
    raise "Номер не может быть 0 или иметь отрицательное значение" if num <= 0
  end
end

class PassengerVan < Van
  attr_reader :num, :type, :seats, :occupied_seats, :available_seats

  def initialize(num, seats)
    @num = num.to_i
    @seats = seats
    validate!
    @type = :passenger
    message
    @occupied_seats = 0
  end

  def take_seat
    @occupied_seats += 1
  end

  def avaliable_seats
    @available_seats = @seats - @occupied_seats
  end

  def message
    puts "Создан пассажирский вагон №#{@num}"
   end

end

class CargoVan < Van
  attr_reader :num, :type, :volume, :occupied_volume, :free_volume

  def initialize(num, volume)
    @num = num.to_i
    @volume = volume
    validate!
    @type = :cargo
    @occupied_volume = 0
    message
  end

  def occupy_volume(volume)
    @occupied_volume += volume
  end

  def free_volume
    @free_volume = @volume - @occupied_volume
  end

  def message
    puts "Создан грузовой вагон №#{@num}"
   end

end