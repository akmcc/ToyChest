def romanize(number)

roman_numeral = ""

if number == 0
    return "please give me a number greater than zero"
end

one = "I"
five = "V"
ten = "X"
fifty = "L"
hundred = "C"

remainder = number

write = remainder/100 #find out how many hundreds 
remainder = remainder - write*100

if write > 0 
     roman_numeral = roman_numeral + "#{write.times{print hundred}}"
end

write = remainder/50 #find out how many fifties
remainder = remainder - write*50

if write > 0
    roman_numeral = roman_numeral + "#{write.times{print fifty}}"
end

write = remainder/10 #find out how many tens
remainder = remainder - write*10

if write > 0
    roman_numeral = roman_numeral + "#{write.times{print ten}}"
end

write = remainder/5 #find out how many fives
remainder = remainder - write*5

if write > 0
    roman_numeral = roman_numeral + "#{write.times{print five}}"
end

write = remainder #only ones left

if write > 0
    roman_numeral = roman_numeral + "#{write.times{print one}}"
end

end

romanize(466)
puts



