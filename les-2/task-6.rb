basket = {}

loop do
  print "Enter product name: "
  product = gets.chomp.to_s

  break if product == "stop"

  print "Enter price per unit: "
  price_per_unit = gets.chomp.to_f
  print "Enter quantity: "
  quantity = gets.chomp.to_f

  basket[product] = {price: price_per_unit, quantity: quantity}
end

sum = 0

basket.each do |product, data|
  product_sum = data[:price] * data[:quantity]
  puts "#{product}: #{product_sum}"
  sum = sum + product_sum
end

puts sum

