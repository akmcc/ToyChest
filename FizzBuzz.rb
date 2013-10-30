
 (1...100).each do |n|
  word = ""
  word += "Fizz" if n % 3 == 0
  word += "Buzz" if n % 3 == 0
  puts (word == "" ? n : word)
end