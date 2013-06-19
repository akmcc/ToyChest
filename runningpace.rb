puts "How many miles did you run today?"
d = gets.chomp.to_f
puts "How many minutes (round to the nearest whole number) did it take you to complete this run?"
t = gets.chomp.to_f
pace = t/d
puts "You ran at a #{pace} minute/mile pace."

if pace < 8
	puts "Well done!"
elsif pace > 9.5
	puts "What? Surely you ran faster than that, right?"
else
	puts "Let's pick up the pace next time..."
end