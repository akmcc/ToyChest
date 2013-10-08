class Calculator
  def find_characters(string)
    @characters = string.split(" ")
    @characters = @characters.map do |char|
      if char.to_i != 0
        char.to_i
      else
        char = char
      end
    end
  end

  def left_of(operator)
    (@characters.index(operator))-1
  end

  def right_of(operator)
    (@characters.index(operator))+1
  end

  def eval
    if @characters.include?("*")
      value = @characters[left_of("*")] * @characters[right_of("*")]
      @characters[left_of("*")..right_of("*")] = [value]

    elsif @characters.include?("/")
      value = @characters[left_of("/")] / @characters[right_of("/")]
      @characters[left_of("/")..right_of("/")] = [value]
     
    elsif @characters.include?("+")
      value = @characters[left_of("+")] + @characters[right_of("+")]
      @characters[left_of("+")..right_of("+")] = [value]
     
    elsif @characters.include?("-")
      value = @characters[left_of("-")] - @characters[right_of("-")]
      @characters[left_of("-")..right_of("-")] = [value] 
    end
    if @characters.size > 1
        eval
    end
  end

  def calculate(string)
    find_characters(string)
    eval
    @characters
  end
end

thing = Calculator.new
puts thing.calculate("2 * 3 * 4")
puts thing.calculate("2 + 3 + 6 - 1")
puts thing.calculate("2 + 3 * 7")
puts thing.calculate("1 + 9 / 3 ")