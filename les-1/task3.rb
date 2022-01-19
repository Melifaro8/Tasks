print "Enter side a: "
a = gets.chomp.to_i
print "Enter side b: "
b = gets.chomp.to_i
print "Enter side c: "
c = gets.chomp.to_i

array = [ a, b, c ]
array.sort!
array.reverse!

if array[0]**2 == array[1]**2 + array[2]**2
    puts "This is right triangle"
elsif (array[0] == array[1]) && (array[1] == array[2])
    puts "This is equilateral triangle"
elsif (array[0] == array[1]) || (array[1] == array[2]) || (array[2] == array[0])
    puts "This is isosceles triangle"
else
    puts "This is not equilateral, right or isosceles triangle"
end