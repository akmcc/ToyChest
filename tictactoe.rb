class TicTacToe

	def initialize
	  enter_line
	  puts "Let's play Tic Tac Toe"
	  @first_row = [[" "], [" "], [" "]]
	  @second_row = [[" "], [" "], [" "]]
	  @third_row = [[" "], [" "], [" "]]
	  @play_count = 0
	end

	def print_board
		puts "      A      B      C"
		print "1  "
		print @first_row
		puts
		print "2  "
		print @second_row
		puts
		print "3  "
		print @third_row
		puts
	end

	def enter_line
	  puts "---------------------------------------------------------"
	end

	def space_full
		puts "SORRY. That space has already been selected."
		@play_count -= 1
		player_turn
	end

	def get_move
	  puts "The board is as follows:" 
	  print_board
	  puts
	  puts "What space would you like to play? (ex: a1, b2, or c3)"
	  @selection = gets.chomp
	end

	def assign_player_selection
	  case @selection
	  when "a1" then player_selection = @first_row[0]
	  when "b1" then player_selection = @first_row[1]
	  when "c1" then player_selection = @first_row[2]
	  when "a2" then player_selection = @second_row[0]
	  when "b2" then player_selection = @second_row[1]
	  when "c2" then player_selection = @second_row[2]
	  when "a3" then player_selection = @third_row[0]
	  when "b3" then player_selection = @third_row[1]
	  when "c3" then player_selection = @third_row[2]
	  end
	  return player_selection
	end

	def check_if_empty
	  player_selection = assign_player_selection
	  if player_selection == [" "]
	  	enter_move
	  else
	  	space_full
	  end
	end

	def user_mark
	  if @play_count % 2 != 0
	  	return ["X"]
	  elsif @play_count % 2 == 0
	  	return ["O"]
	  end
	end

	def enter_move
		player_selection = assign_player_selection
		player_selection.replace(user_mark)
	end

	def player_turn
	@play_count += 1
	enter_line
	if @play_count % 2 != 0
		puts "Player 1, your move."
	elsif @play_count % 2 == 0
		puts "Player 2, your move."
	end
	get_move
	assign_player_selection
	check_if_empty
	check_for_winner
	player_turn
	end

	def check_for_winner
		if @first_row[0] != [" "] && @first_row[0] == @first_row[1] & @first_row[2]
		  game_over
		elsif @second_row[0] != [" "] && @second_row[0] == @second_row[1] & @second_row[2]
		  game_over
		elsif @third_row[0] != [" "] && @third_row[0] == @third_row[1] & @third_row[2]
		  game_over
		elsif @first_row[0] != [" "] && @first_row[0] == @second_row[0] & @third_row[0]
			game_over
		elsif @first_row[1] != [" "] && @first_row[1] == @second_row[1] & @third_row[1]
			game_over
		elsif @first_row[2] != [" "] && @first_row[2] == @second_row[2] & @third_row[2]
			game_over
		elsif @first_row[0] != [" "] && @first_row[0] == @second_row[1] & @third_row[2]
			game_over
		elsif @first_row[2] != [" "] && @first_row[2] == @second_row[1] & @third_row[0]
			game_over
		elsif @first_row.all? {|space| space != [" "]} && @second_row.all? {|space| space != [" "]} && @third_row.all? {|space| space != [" "]}
			game_over
		end
	end

	def game_over
	  print_board
	  puts
	  abort("GAME OVER!")
	end
end

game = TicTacToe.new
game.player_turn