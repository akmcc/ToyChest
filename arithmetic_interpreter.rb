class Calculator
  def find_characters(string)
    @characters = string.split(" ")
    @characters = @characters.map do |char|
      if char.match(/\d/)
        char.to_i
      else
        char = char
      end
    end
  end

  # def left_of(operator)
  #   (@characters.index(operator))-1
  # end

  # def right_of(operator)
  #   (@characters.index(operator))+1
  # end

  def find_matching_paren(characters)
    @paren_element = characters
    paren_count = 0 
    characters.each_with_index do |char, index|
      if char == "("
        paren_count += 1
      elsif char == ")"
        paren_count -= 1
      end
      if paren_count == 0
        @matching_paren_index = index
      end
    end 
  end

  def find_subset_between_parens(characters) 
    characters = characters[1..(@matching_paren_index-1)] 
    characters
  end

  def eval(characters)
    if characters.include?("(")
      find_matching_paren(characters[characters.index("(")..-1])
      sub_characters = find_subset_between_parens(@paren_element)
      value = eval(sub_characters)
      characters[characters.index("(")..characters.index(characters.last)] = value
    elsif characters.include?("*")
        value = characters[characters.index("*")-1] * characters[characters.index("*")+1]
        characters[(characters.index("*")-1)..(characters.index("*")+1)] = [value]
      elsif characters.include?("/")
        value = characters[characters.index("/")-1] / characters[characters.index("/")+1]
        characters[(characters.index("/")-1)..(characters.index("/")+1)] = [value]
      elsif characters.include?("+")
        value = characters[characters.index("+")-1] + characters[characters.index("+")+1]
        characters[(characters.index("+")-1)..(characters.index("+")+1)] = [value]
      elsif characters.include?("-")
        value = characters[characters.index("-")-1] - characters[characters.index("-")+1]
        characters[(characters.index("-")-1)..(characters.index("-")+1)] = [value] 
      end
    if characters.size > 1
      eval(characters)
    end 
    characters
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
#  puts thing.calculate("1 + 99 / 3 ")
 puts thing.calculate("2 * ( 3 + 7 )") #input has to have a space between each element or it will break everything
#puts thing. calculate("2 * ( 3 * ( 1 + 2 ) )")