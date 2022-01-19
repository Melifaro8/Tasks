print "Enter index a: "
a = gets.chomp.to_i
print "Enter index b: "
b = gets.chomp.to_i
print "Enter index c: "
c = gets.chomp.to_i

D = (b ** 2) - 4 * a * c

if D <= 0
  puts "There is no roots"
elsif D == 0
  x = (-b + Math.sqrt(D))/2*a
  puts "x = #{x}"
else D >= 0
  x1 = (-b + Math.sqrt(D))/2*a
  x2 =  (-b - Math.sqrt(D))/2*a   
  puts " x1 = #{x1} , x2 = #{x2} "
end

 