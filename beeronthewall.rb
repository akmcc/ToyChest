def spell_number(number)
string_number = ""

if number == 0
  return "zero"
end

ones = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
tens = ["ten", "twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"]
teens = ["eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

write = number/1000000000 #find out how many billions
remainder = number - number*1000000000

if write > 0
    billions = spell_number(write)
    string_number = string_number + billions + " billion"
    if remainder > 0
        string_number = string_number + " "
    end
end

write = remainder/1000000 #find out how many millions
remainder = remainder - write*1000000

if write > 0
    millions = spell_number(write)
    string_number = string_number + millions + " million"
    if remainder > 0
        string_number = string_number + " "
    end
end

write = remainder/1000 #find out how many thousands
remainder = remainder - write*1000

if write > 0
    thousands = spell_number(write)
    string_number = string_number + thousands + " thousand"
    if remainder > 0
        string_number = string_number + " "
    end
end

write = remainder/100 #find out how many hundreds
remainder = remainder - write*100

if write > 0
    hundreds = spell_number(write)
    string_number = string_number + hundreds + " hundred"
    if remainder > 0 
        string_number = string_number + " "
    end
end

write = remainder/10 #find out how many tens
remainder = remainder - write*10

if write > 0
    if ((write == 1) && (remainder > 0))
        string_number = string_number + teens[write-1]
        remainder = 0
    else
        string_number = string_number + tens[write-1]
    end
    if remainder > 0
        string_number = string_number + " "
    end
end

write = remainder #only ones are left
remainder = 0

if write > 0
    string_number = string_number + ones[write-1]
end


string_number
end

def sing_about_beers(amount) 
while amount > 1
  puts spell_number(amount) + " bottles of beer on the wall."
  puts spell_number(amount) + " bottles of beer." 
  puts "take one down and pass it around." 
  puts spell_number(amount-1) + " bottles of beer on the wall."
  puts
  amount -= 1
end
if amount == 1
  puts spell_number(amount) + " bottle of beer on the wall."
  puts spell_number(amount) + " bottle of beer." 
  puts "take one down and pass it around." 
  puts spell_number(amount-1) + " bottles of beer on the wall."
  puts
end

end

sing_about_beers(99)
