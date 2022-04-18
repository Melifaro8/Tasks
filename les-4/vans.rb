require_relative 'modules'
require_relative 'accessors'
require_relative 'validation'


class Van
  include Factory
  include Accessors
  include Validation

  attr_reader :num, :type, :seats

  validate :clas, :type, "Van"

  @attempt = 0

  def initialize(num, _seats = 'Unknown', _volume = 'Unknown')
    @num = num.to_i
  end
end

class PassengerVan < Van
  attr_reader :num, :type, :seats, :occupied_seats, :available_seats

  def initialize(num, seats)
    super
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
  attr_reader :num, :type, :volume, :occupied_volume

  def initialize(num, volume)
    super
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
