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

  def eval
    if @characters.include?("*")
      value = (@characters[(@characters.index("*"))-1]) * (@characters[(@characters.index("*"))+1])
      @characters[((@characters.index("*"))-1)..((@characters.index("*"))+1)] = [value]
     
    elsif @characters.include?("+")
      value = (@characters[(@characters.index("+"))-1]) + (@characters[(@characters.index("+"))+1])
      @characters[((@characters.index("+"))-1)..((@characters.index("+"))+1)] = [value]
     
    elsif @characters.include?("-")
      value = (@characters[(@characters.index("-"))-1]) - (@characters[(@characters.index("-"))+1])
      @characters[((@characters.index("-"))-1)..((@characters.index("-"))+1)] = [value]  
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
