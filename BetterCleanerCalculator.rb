class EasierCalculator
  def initialize
    @stack = []
    @post_fix = []
    @pre_fix = []
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
          if prescedence_of(char)  <= prescedence_of(@stack.last)
            @post_fix << @stack.pop #will I ever need to add three operators from the stack? 
            if @stack.last && prescedence_of(char) <= prescedence_of(@stack.last) #also need to make sure the stack.last is an operator! 
              @post_fix << @stack.pop
            end
          end
        end
          @stack << char
      elsif char == "("
        @stack << char
      elsif char == ")"
        until @stack.last == "("
          @post_fix << @stack.pop
        end
        @stack.pop #throw away the left paren that was stored in the stack ## does this assume I only have 1 left paren in the stack at a time? 
      end
    end 
    until @stack.empty?
      @post_fix << @stack.pop
    end 
  end

  def reduce(variable)
    if variable.size > 1
     evaluate(variable)
    elsif variable.size == 1
     variable.pop
    end
  end

  def evaluate pre_fix
    print "prefix chars at beginning of evaluate method are: #{pre_fix}"
    puts
    op, left_var, *right_var = pre_fix
    if op == "*"
      value = left_var * reduce(right_var)
    elsif op == "/"
      value = left_var / reduce(right_var)
    elsif op == "+"
      value = left_var + reduce(right_var)
    elsif op == "-"
      value = left_var - reduce(right_var)
    end
    value
  end

  def calculate string
    characters = tokenize string
    convert_to_postfix characters
    print "post_fix characters are: #{@post_fix}"
    puts
    @pre_fix = @post_fix.reverse #converts to prefix
    evaluate @pre_fix
  end

end


thing = EasierCalculator.new
# print thing.calculate "1 + 2 + 4"
# puts
# print thing.calculate "7 * 2 + 4"
# puts
print thing.calculate "( 2 + 4 ) * 1" #program works if parens are at beginning of expression. 
puts



