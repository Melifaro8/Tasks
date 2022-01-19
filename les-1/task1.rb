print "What's your name?"
name = gets.chomp
print "What's your height?"
height = gets.chomp.to_f
print "What's your weight?"
weight= gets.chomp.to_f
ideal_weight = (height - 110) * 1.15
difference = weight - ideal_weight.to_f
if difference.to_f <= 0
  puts " #{name.capitalize},  your weight already optimal!"
else 
  puts  "#{name.capitalize}, your optimal weight is #{ideal_weight.to_f}"
end
