my_array = [0, 1, 1]

loop do |x|
  x = my_array[-1] + my_array[-2]
  my_array << x
  break if x > 100
end

puts my_array