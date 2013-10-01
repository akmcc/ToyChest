def romanize(number)
  roman_numeral = ""
  if number == 0
    return "please give me a number greater than zero"
  end
  remainder = number
  write = remainder/1000 #find out how many thousands
  remainder = remainder - write*1000
  if write > 0
    roman_numeral = roman_numeral + ("M" * write)
  end
  
  # write = remainder/500 #find out how many five-hundreds
  # remainder = remainder - write*500
  # if write > 0
  #   roman_numeral = roman_numeral + ("D" * write)
  # end

  write = remainder/100 #find out how many hundreds 
  remainder = remainder - write*100
  if write > 0 
    if write == 4
      roman_numeral += "CD"
    elsif write == 9
      roman_numeral += "CM"
    elsif write >= 5
      roman_numeral = roman_numeral + "D"
      write = write - 5
      roman_numeral = roman_numeral + ("C" * write)
    else 
      roman_numeral = roman_numeral + ("C" * write)
    end
  end
  
  # write = remainder/50 #find out how many fifties
  # remainder = remainder - write*50
  # if write > 0
  #   roman_numeral = roman_numeral + ("L" * write)
  # end

  write = remainder/10 #find out how many tens
  remainder = remainder - write*10
  if write > 0
    if write == 4
        roman_numeral = roman_numeral + "XL"
    elsif write == 9
        roman_numeral = roman_numeral + "XC"
    elsif write >= 5
      roman_numeral = roman_numeral + "L"
      write = write - 5
      roman_numeral = roman_numeral + ("X" * write)
    else 
        roman_numeral = roman_numeral + ("X" * write)
    end
  end

  # write = remainder/5 #find out how many fives
  # remainder = remainder - write*5
  # if write > 0
  #   roman_numeral = roman_numeral + ("V" * write)
  # end  

  write = remainder #only ones left
  if write > 0
    if write == 4
      roman_numeral = roman_numeral + "IV"
    elsif write == 9
      roman_numeral = roman_numeral + "IX"
    elsif write >= 5
      roman_numeral = roman_numeral + "V"
      write = write - 5
      roman_numeral = roman_numeral + ("I" * write)
    else
      roman_numeral = roman_numeral + ("I" * write)
  end
end
roman_numeral
end

# puts romanize(999)


def tester(arg, expected_answer)
  actual_answer = romanize(arg)
  if actual_answer != expected_answer
    puts "\e[31mtest failed on #{arg}\e[0m"
    puts "#{actual_answer} not equal to #{expected_answer}"
  else
    puts "\e[32mtest passed for #{arg}\e[0m"
  end
end

tester(999, "CMXCIX")
tester(99, "XCIX")
tester(50, "L")
tester(45, "XLV")
tester(444, "CDXLIV")

