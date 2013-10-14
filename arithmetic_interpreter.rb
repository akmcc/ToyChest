class Calculator
  def tokenize(string)
    characters = string.split(" ")
    characters = characters.map do |char|
      if char.match(/\d/)
        char.to_i
      else
        char = char
      end
    end
    print "in tokenize characters are: #{characters}"
    puts
    characters
  end

  def left_of(operator, environment)
    environment[environment.index(operator)-1]
  end

  def right_of(operator, environment)
    environment[environment.index(operator)+1]
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
        @matching_paren_index = index
        break
      end
    end 
     print "in find matching paren characters are: #{characters}"
    puts
    @matching_paren_index
  end

  def find_subset_between_parens(characters) 
    characters = characters[1..(@matching_paren_index-1)] 
     print "in find subset characters are: #{characters}"
    puts
    characters
  end

  def evaluate(characters)
    if characters.include?("(")
      paren_element = characters[characters.index("(")..-1]
      find_matching_paren(paren_element)
      sub_characters = find_subset_between_parens(paren_element)
      value = evaluate(sub_characters)
      print "after assigning subset to sub_characters characters are: #{characters}"
      puts
      print "after assigning subset to sub_characters characters.last is: #{characters.last}"
      puts
      characters[characters.index("(")..-1] = value #This is not what I want to be doing! Not last! 
    elsif characters.include?("*")
        value = left_of("*", characters) * right_of("*", characters)
        characters[(characters.index("*")-1)..(characters.index("*")+1)] = [value]
      elsif characters.include?("/")
        value = value = left_of("/", characters) / right_of("/", characters)
        characters[(characters.index("/")-1)..(characters.index("/")+1)] = [value]
      elsif characters.include?("+")
        value = value = left_of("+", characters) + right_of("+", characters)
        characters[(characters.index("+")-1)..(characters.index("+")+1)] = [value]
      elsif characters.include?("-")
        value = value = left_of("-", characters) - right_of("-", characters)
        characters[(characters.index("-")-1)..(characters.index("-")+1)] = [value] 
      end
    if characters.size > 1
      evaluate(characters)
    end 
    characters
  end


  def calculate(string)
    characters = tokenize(string)
    evaluate(characters)
    characters
  end
end

thing = Calculator.new
#puts thing.calculate("20 * 30 * 40")
#puts thing.calculate("2 + 3 + 6 - 1")
#puts thing.calculate("2 + 3 * 7")
#puts thing.calculate("1 + 99 / 3 ")
puts thing.calculate("2 * ( 3 + 7 )") #input has to have a space between each element or it will break everything
puts thing. calculate("2 * ( 3 * ( 1 + 2 ) )")