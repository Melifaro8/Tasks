print "Enter number of date: "
day = gets.chomp.to_i
print "Enter month: "
month = gets.chomp.to_i
print "Enter year: "
year = gets.chomp.to_i

if year % 4 != 0 
  leap_year = false
else
  year % 100 != 0 && year % 400 == 0 
  leap_year = true
end

calendar = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if leap_year
  calendar[1] = 28
else
  calendar[1] = 29
end

sum = calendar.take(month - 1).sum + day

puts sum

