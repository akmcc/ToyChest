
def findPace (t, d)
	#calculates pace from time and distance input from user
	@pace = (t/d).round(2)
end

#obtain time and distance input from user  
puts "How many miles did you run today?"
d = gets.chomp.to_f
puts "How many minutes did it take you to complete this run?"
puts "(ex: 120.75 minutes = 2 hrs 45 seconds)"
t = gets.chomp.to_f

#call findPace method
findPace(t, d)

#output pace
puts "You ran at a #{@pace} minute/mile pace."

#provide feedback
if @pace <= 8  #faster than 8
	puts "Well done!"
elsif @pace > 9.5 && @pace < 11 #between 9.5 and 11
	puts "What? Surely you ran faster than that, right?"
elsif @pace >= 11
	puts "You weren't running. You must've been meandering."
else #all other times, 8 - 9.5
	puts "Let's pick up the pace next time..."
end