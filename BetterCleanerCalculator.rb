class EasierCalculator
  def initialize
    @stack = []
    @post_fix = []
  end

  def tokenize string
    characters = string.split(" ")
    characters =  characters.map do |char|
      if char.match(/\d/)
        char.to_i
      else
        char = char
      end
    end
  end

  def prescedence_of operator
    case operator
    when "*" then 2
    when "/" then 2
    when "+" then 1
    when "-" then 1
    when "(" then 0  
    end
  end

  def convert_to_postfix characters
    characters.each do |char|
      if char.is_a? Integer
        @post_fix << char
      elsif char == "("
        @stack << char
      elsif char.match(/[\*\/\+\-]/)
        if @stack.last && @stack.last.match(/[\*\/\+\-\(\)]/) 
          puts prescedence_of(char)
          puts prescedence_of(@stack.last)
          if (prescedence_of(char) <= prescedence_of(@stack.last))
            @post_fix << (@stack.pop) #may sometimes need to add more than one operator from the stack to the post_fix array
          end
        end
          @stack << char
      elsif char == "("
        @stack << char
      elsif char == ")"
        until @stack.last == "("
          @post_fix << (@stack.pop)
        end
        @stack.pop #throw away the left paren that was in the stack ## does this assume I only have 1 left paren? 
      end
    end 
    until @stack.empty?
      @post_fix << (@stack.pop)
      print "post_fix is #{@post_fix}"
      puts
    end 
  end


  # def evaluate post_fix_chars
  # end

  def calculate string
    characters = tokenize string
    convert_to_postfix characters

    #value = evaluate @post_fix

    #will want to return value at the end
  end

end


thing = EasierCalculator.new
print thing.calculate "( 2 + 7 ) * ( 2 + 1 )"
puts