
def findPace (t, d)
	@pace = (t/d).round(2)
end
  
puts "How many miles did you run today?"
d = gets.chomp.to_f
puts "How many minutes did it take you to complete this run?"
puts "(ex: 120.75 minutes = 2 hrs 45 seconds)"
t = gets.chomp.to_f

findPace(t, d)

puts "You ran at a #{@pace} minute/mile pace."

if @pace <= 8  #faster than 8
	puts "Well done!"
elsif @pace > 8 && @pace <= 9.5 #between 8 and 9.5
	puts "Let's pick up the pace next time..."
elsif @pace > 9.5 && @pace <= 11 #between 9.5 and 11
	puts "What? Surely you ran faster than that, right?"
else #anything slower than 11
	puts "You weren't running. You must've been meandering."
end