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
  
  hundred = { 4 => "DC", 
        9 => "CM",
        5 => "D",
        1 => "C" }

ten = {  4 => "XL",
        9 => "XC",
        5 => "L",
        1 => "X" }

one = {   4 => "IV",
        9 => "IX",
        5 => "V",
        1 => "I" }
  
  remainder = number
  @write = remainder/1000 #find out how many thousands
  remainder = remainder - @write*1000
  if @write > 0
    @roman_numeral += ("M" * @write)
  end
 
  @write = remainder/100 #find out how many hundreds 
  remainder = remainder - @write*100
    translate_for(hundred)


  @write = remainder/10 #find out how many tens
  remainder = remainder - @write*10

  translate_for(ten)


  @write = remainder #only ones left

  translate_for(one)

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


