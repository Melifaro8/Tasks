string_AZ = Hash[("a".."z").to_a.zip((1..26).to_a)]

st_AY = string_AZ.select { |k, v| k == "a" || k == "e" || k == "i" || k == "o" || k == "u" || k == "y"}

puts st_AY