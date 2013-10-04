require 'colorize'

class Palindrome_checker
  def initialize
    @normal_order = []
    @reversed_order = []
    @reversed_word = ""
  end


  def my_reverse(word)
    word.each_char do |char|
      @normal_order.push(char)
    end
    still_to_reverse = @normal_order.dup
    until still_to_reverse.size == 0
      current = still_to_reverse.pop
      @reversed_order.push(current)
    end
    @reversed_word = @reversed_order.join
  end
   
  def check_for_palindrome(word)
    my_reverse(word)
    if word == @reversed_word
      puts "This word is a palindrome!"
    else
      puts "You have not identified a palindrome yet."
    end
  end


 def tester(word)
   my_reverse(word) 
   if word.reverse != @reversed_word
     puts "This isn't working".red
     puts "Your method reversed #{word} as #{@reversed_word}."
   else
     puts "You did it!".green
   end
 end

end

thing = Palindrome_checker.new
thing.check_for_palindrome("alula")

