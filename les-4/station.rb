class Station
  attr_reader :train_list, :name

  def initialize(name)
    @name = name
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