print "Enter side a: "
a = gets.chomp.to_i
print "Enter side b: "
b = gets.chomp.to_i
print "Enter side c: "
c = gets.chomp.to_i

a, b, hypo = [a, b, c].sort


if hypo[0]**2 == hypo[1]**2 + hypo[2]**2
  puts "This is right triangle"
elsif (hypo[0] == hypo[1]) && (hypo[1] == hypo[2])
  puts "This is equilateral triangle"
elsif (hypo[0] == hypo[1]) || (hypo[1] == hypo[2]) || (hypo[2] == hypo[0])
  puts "This is isosceles triangle"
else
  puts "This is not equilateral, right or isosceles triangle"
end