
def findPace (time, distance)
  return (time/distance).round(2)
end

def getRunInfo
	puts "How many miles did you run?"
	distance = gets.chomp.to_f
	puts "How many minutes did it take you to complete this run?"
	puts "(ex: 120.75 minutes = 2 hrs 45 seconds)"
	time = gets.chomp.to_f
	return findPace(time, distance)
end

@last_five_paces = []

def runner
	pace = getRunInfo

	puts "You ran at a #{pace} minute/mile pace."
	if pace <= 8.5  
		puts "Well done!"
	else #anything slower than 8.5
		puts "Let's pick up the pace next time..."
	end

	if @last_five_paces.size == 5
		@last_five_paces.shift
	end
	@last_five_paces<<pace

	puts "Would you like to log another run [y/n]?"
	another_run = gets.chomp

	if another_run == "y"
		runner 
	elsif another_run == "n"
		sum_of_paces = @last_five_paces.inject(0.0) {|sum, pace| sum + pace}
	  average_pace = (sum_of_paces/@last_five_paces.size).round(2)
	  puts "The average pace of your most recent (up to five) runs is #{average_pace} minutes per mile."
	end     
end

runner


