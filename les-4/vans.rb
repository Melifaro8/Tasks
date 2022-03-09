require_relative 'modules'

class Van
  include Factory
  attr_reader :num, :type
  
  @@attempt = 0

  def initialize(num)
    @num = num
    message
  end

  protected

  def validate!
    raise "Номер не может быть 0 или иметь отрицательное значение" if num <= 0
  end

  def message
    puts "Создан вагон №#{@num} типа #{@type}"
   end
end

class PassengerVan < Van
  attr_reader :num, :type

  def initialize(num)
    validate!
    super
    @type = :passenger
  end
end

class CargoVan < Van
  attr_reader :num, :type

  def initialize(num)
    validate!
    super
    @type = :cargo
  end
end