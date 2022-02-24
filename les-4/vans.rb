require_relative 'modules'

class Van
  include Factory
  attr_reader :num, :type

  def initialize(num)
    @num = num
  end
end

class PassengerVan < Van
  attr_reader :num, :type

  def initialize(num)
    super
    @type = "пассажирский"
  end
end

class CargoVan < Van
  attr_reader :num, :type

  def initialize(num)
    super
    @type = "грузовой"
  end
end