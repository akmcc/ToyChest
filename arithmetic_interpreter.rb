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

  def find_matching_paren(characters)
    paren_count = 0
    characters.each_with_index do |char, index|
      if char == "("
        paren_count += 1
      elsif char == ")"
        paren_count -= 1
      end
      if paren_count == 0
        matching_paren_index = index
        return matching_paren_index
      end
    end 
  end

  def eval(characters)
    if characters.include?("(")
      characters = characters[characters.index("(")..find_matching_paren(characters)] 
        eval(characters) 
      elsif characters.include?("*")
        value = characters[left_of("*")] * characters[right_of("*")]
        characters[left_of("*")..right_of("*")] = [value]
      elsif characters.include?("/")
        value = characters[left_of("/")] / characters[right_of("/")]
        characters[left_of("/")..right_of("/")] = [value]
      elsif characters.include?("+")
        value = characters[left_of("+")] + characters[right_of("+")]
        characters[left_of("+")..right_of("+")] = [value]
      elsif characters.include?("-")
        value = characters[left_of("-")] - characters[right_of("-")]
        characters[left_of("-")..right_of("-")] = [value] 
      end
      if characters.size > 1
        eval(characters)
      end 
    end
    def calculate(string)
      find_characters(string)
      eval(@characters)
      @characters
    end
  end

thing = Calculator.new
# puts thing.calculate("20 * 30 * 40")
# puts thing.calculate("2 + 3 + 6 - 1")
# puts thing.calculate("2 + 3 * 7")
# puts thing.calculate("1 + 99 / 3 ")
puts thing.calculate("2 * ( 3 + 7 )")