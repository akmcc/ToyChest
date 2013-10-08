def calculate(string)
  characters = string.split(" ")
  characters = characters.map do |char|
                 if char.to_i != 0
                    char.to_i
                 else
                    char = char
                 end
               end

print characters
puts
  num1 = characters[0]
  operator = characters[1]
  num2 = characters[2]


case operator
when "+" then puts num1 + num2
when "*" then puts num1 * num2
when "-" then puts num1 - num2
end

end

calculate("2 + 2")
calculate("2 * 3")
calculate("6 - 3")
