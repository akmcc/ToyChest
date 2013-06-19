amount = 99
while amount > 0
  puts "#{amount} bottles of beer on the wall."
  puts "#{amount} bottles of beer." 
  puts "Take one down and pass it around." 
  puts "#{amount - 1} bottles of beer on the wall"
  puts ' '
  amount -= 1
  if amount == 0
    break
  end
end

puts "Where'd all the beer go?"
