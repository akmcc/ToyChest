def spell_number(number)

string_number = ""

write = number/1000

case write
when 1 then string_number = (string_number + " one thousand")
when 2 then string_number = (string_number + " two thousand")
when 3 then string_number = (string_number + " three thousand")
when 4 then string_number = (string_number + " four thousand")
when 5 then string_number = (string_number + " five thousand")
when 6 then string_number = (string_number + " six thousand")
when 7 then string_number = (string_number + " seven thousand")
when 8 then string_number = (string_number + " eight thousand")
when 9 then string_number = (string_number + " nine thousand")
end

remainder = number - write*1000

write = remainder/100

case write
when 1 then string_number = (string_number + " one hundred")
when 2 then string_number = (string_number + " two hundred")
when 3 then string_number = (string_number + " three hundred")
when 4 then string_number = (string_number + " four hundred")
when 5 then string_number = (string_number + " five hundred")
when 6 then string_number = (string_number + " six hundred")
when 7 then string_number = (string_number + " seven hundred")
when 8 then string_number = (string_number + " eight hundred")
when 9 then string_number = (string_number + " nine hundred")
end

remainder = remainder - write*100

write = remainder/10

case write
when 1 then string_number = (string_number + " this part gets tricky")
when 2 then string_number = (string_number + " twenty")
when 3 then string_number = (string_number + " thirty")
when 4 then string_number = (string_number + " fourty")
when 5 then string_number = (string_number + " fifty")
when 6 then string_number = (string_number + " sixty")
when 7 then string_number = (string_number + " seventy")
when 8 then string_number = (string_number + " eighty")
when 9 then string_number = (string_number + " ninety")
end

remainder = remainder - write*10

write = remainder

case write
when 1 then string_number = (string_number + " one")
when 2 then string_number = (string_number + " two")
when 3 then string_number = (string_number + " three")
when 4 then string_number = (string_number + " four")
when 5 then string_number = (string_number + " five")
when 6 then string_number = (string_number + " six")
when 7 then string_number = (string_number + " seven")
when 8 then string_number = (string_number + " eight")
when 9 then string_number = (string_number + " nine")
end


puts string_number

end

puts "Give me a number between 0 and 9,999:"
input = gets.chomp.to_i
spell_number(input)

