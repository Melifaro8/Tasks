string_az = Hash[("a".."z").to_a.zip((1..26).to_a)]

st_ay = string_az.select { |k, _| [ "a", "e", "i", "o", "u", "y"].include?(k) }

puts st_ay