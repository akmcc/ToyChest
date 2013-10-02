require "colorize"

class Roman_numbers

def initialize
  @write = ""
  @roman_numeral = ""
end

def romanize(number)
 @roman_numeral="" 
  
if number == 0
  return "please give me a number greater than zero"
end
digits = {

  :thousands => {
        "num" => 1000,
        1 => "M"},

  :hundred => { 
        "num" => 100,
        4 => "DC", 
        9 => "CM",
        5 => "D",
        1 => "C" },

:ten => {  
        "num" => 10,
        4 => "XL",
        9 => "XC",
        5 => "L",
        1 => "X" },

:one => {   
        "num" => 1,
        4 => "IV",
        9 => "IX",
        5 => "V",
        1 => "I" }}

remainder = number

digits.each do |key, value|
  @write = remainder/value["num"] 
  remainder = remainder - @write*value["num"]
  translate_for(value)
end

@roman_numeral
end

def translate_for(arg)

if @write > 0
  if @write == 4
    @roman_numeral += arg[4] 
  elsif @write == 9
    @roman_numeral += arg[9]
  elsif @write >= 5
    @roman_numeral += arg[5]
    @write = @write - 5
    @roman_numeral += (arg[1] * @write)
  else 
    @roman_numeral += (arg[1] * @write)
  end
end
end

def tester(arg, expected_answer)
  actual_answer = romanize(arg)
  if actual_answer != expected_answer
    puts "test failed on #{arg}".red
    puts "#{actual_answer} not equal to #{expected_answer}"
  else
    puts "test passed for #{arg}".green
  end
end

end

number = Roman_numbers.new

number.tester(999, "CMXCIX")
number.tester(99, "XCIX")
number.tester(50, "L")


